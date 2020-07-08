require 'spec_helper'

describe Spree::Admin::PaymentsController, type: :controller do
  let!(:shop) { create(:enterprise) }
  let!(:user) { shop.owner }
  let!(:order) { create(:order, distributor: shop, state: 'complete') }
  let!(:line_item) { create(:line_item, order: order, price: 5.0) }

  before do
    allow(controller).to receive(:spree_current_user) { user }
  end

  context "#create" do
    let!(:payment_method) { create(:payment_method, distributors: [shop]) }
    let(:params) { { amount: order.total, payment_method_id: payment_method.id } }

    context "order is not complete" do
      let!(:order) do
        create(:order_with_totals_and_distribution, distributor: shop, state: "payment")
      end

      it "advances the order state" do
        expect {
          spree_post :create, payment: params, order_id: order.number
        }.to change { order.reload.state }.from("payment").to("complete")
      end
    end

    context "order is complete" do
      let!(:order) do
        create(:order_with_totals_and_distribution, distributor: shop,
                                                    state: "complete",
                                                    completed_at: Time.zone.now)
      end

      context "with Check payment (payment.process! does nothing)" do
        it "redirects to list of payments with success flash" do
          spree_post :create, payment: params, order_id: order.number

          redirects_to_list_of_payments_with_success_flash
          expect(order.reload.payments.last.state).to eq "checkout"
        end
      end

      context "with Stripe payment where payment.process! errors out" do
        let!(:payment_method) { create(:stripe_payment_method, distributors: [shop]) }
        before do
          allow_any_instance_of(Spree::Payment).
            to receive(:process!).
            and_raise(Spree::Core::GatewayError.new("Payment Gateway Error"))
        end

        it "redirects to new payment page with flash error" do
          spree_post :create, payment: params, order_id: order.number

          redirects_to_new_payment_page_with_flash_error("Payment Gateway Error")
          expect(order.reload.payments.last.state).to eq "checkout"
        end
      end

      context "with StripeSCA payment" do
        let!(:payment_method) { create(:stripe_sca_payment_method, distributors: [shop]) }

        context "where payment.authorize! raises GatewayError" do
          before do
            allow_any_instance_of(Spree::Payment).
              to receive(:authorize!).
              and_raise(Spree::Core::GatewayError.new("Stripe Authorization Failure"))
          end

          it "redirects to new payment page with flash error" do
            spree_post :create, payment: params, order_id: order.number

            redirects_to_new_payment_page_with_flash_error("Stripe Authorization Failure")
            expect(order.reload.payments.last.state).to eq "checkout"
          end
        end

        context "where payment.authorize! does not move payment to pending state" do
          before do
            allow_any_instance_of(Spree::Payment).to receive(:authorize!).and_return(true)
          end

          it "redirects to new payment page with flash error" do
            spree_post :create, payment: params, order_id: order.number

            redirects_to_new_payment_page_with_flash_error("Authorization Failure")
            expect(order.reload.payments.last.state).to eq "checkout"
          end
        end

        context "where both payment.process! and payment.authorize! work" do
          before do
            allow_any_instance_of(Spree::Payment).to receive(:authorize!) do |payment|
              payment.update state: "pending"
            end
            allow_any_instance_of(Spree::Payment).to receive(:process!).and_return(true)
          end

          it "makes a payment with the provided card details" do
            source_attributes = {
              gateway_payment_profile_id: "pm_123",
              cc_type: "visa",
              last_digits: "4242",
              month: "4",
              year: "2100"
            }

            spree_post :create, payment: params.merge({ source_attributes: source_attributes }),
                                order_id: order.number

            payment = order.reload.payments.last
            expect(payment.source.attributes.transform_keys(&:to_sym)).to include source_attributes
          end

          it "redirects to list of payments with success flash" do
            spree_post :create, payment: params, order_id: order.number

            redirects_to_list_of_payments_with_success_flash
            expect(order.reload.payments.last.state).to eq "pending"
          end
        end
      end

      def redirects_to_list_of_payments_with_success_flash
        expect_redirect_to spree.admin_order_payments_url(order)
        expect(flash[:success]).to eq "Payment has been successfully created!"
      end

      def redirects_to_new_payment_page_with_flash_error(flash_error)
        expect_redirect_to spree.new_admin_order_payment_url(order)
        expect(flash[:error]).to eq flash_error
      end

      def expect_redirect_to(path)
        expect(response.status).to eq 302
        expect(response.location).to eq path
      end
    end
  end
end
