# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::OrdersController, type: :controller do
  include OpenFoodNetwork::EmailHelper

  describe "#invoice" do
    let!(:user) { create(:user) }
    let!(:enterprise_user) { create(:user) }
    let!(:order) { create(:order_with_distributor, bill_address: create(:address), ship_address: create(:address)) }
    let!(:distributor) { order.distributor }
    let(:params) { { id: order.number } }

    context "as a normal user" do
      before { allow(controller).to receive(:spree_current_user) { user } }

      it "should prevent me from sending order invoices" do
        spree_get :invoice, params
        expect(response).to redirect_to unauthorized_path
      end
    end

    context "as an enterprise user" do
      context "which is not a manager of the distributor for an order" do
        before { allow(controller).to receive(:spree_current_user) { user } }

        it "should prevent me from sending order invoices" do
          spree_get :invoice, params
          expect(response).to redirect_to unauthorized_path
        end
      end

      context "which is a manager of the distributor for an order" do
        before { allow(controller).to receive(:spree_current_user) { distributor.owner } }

        context "when the distributor's ABN has not been set" do
          before { distributor.update_attribute(:abn, "") }
          it "should allow me to send order invoices" do
            expect do
              spree_get :invoice, params
            end.to_not change{ Spree::OrderMailer.deliveries.count }
            expect(response).to redirect_to spree.edit_admin_order_path(order)
            expect(flash[:error]).to eq "#{distributor.name} must have a valid ABN before invoices can be sent."
          end
        end

        context "when the distributor's ABN has been set" do
          let(:mail_mock) { double(:mailer_mock, deliver_later: true) }

          before do
            allow(Spree::OrderMailer).to receive(:invoice_email) { mail_mock }
            distributor.update_attribute(:abn, "123")
            setup_email
          end

          it "should allow me to send order invoices" do
            spree_get :invoice, params

            expect(response).to redirect_to spree.edit_admin_order_path(order)
            expect(Spree::OrderMailer).to have_received(:invoice_email)
            expect(mail_mock).to have_received(:deliver_later)
          end
        end
      end
    end
  end

  describe "#print" do
    let!(:user) { create(:user) }
    let!(:enterprise_user) { create(:user) }
    let!(:order) { create(:order_with_distributor, bill_address: create(:address), ship_address: create(:address)) }
    let!(:distributor) { order.distributor }
    let(:params) { { id: order.number } }

    context "as a normal user" do
      before { allow(controller).to receive(:spree_current_user) { user } }

      it "should prevent me from sending order invoices" do
        spree_get :print, params
        expect(response).to redirect_to unauthorized_path
      end
    end

    context "as an enterprise user" do
      context "which is not a manager of the distributor for an order" do
        before { allow(controller).to receive(:spree_current_user) { user } }
        it "should prevent me from sending order invoices" do
          spree_get :print, params
          expect(response).to redirect_to unauthorized_path
        end
      end

      context "which is a manager of the distributor for an order" do
        before { allow(controller).to receive(:spree_current_user) { distributor.owner } }
        it "should allow me to send order invoices" do
          spree_get :print, params
          expect(response).to render_template :invoice
        end
      end
    end
  end
end
