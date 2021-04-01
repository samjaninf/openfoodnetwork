# frozen_string_literal: true

require 'spec_helper'

module Spree
  describe Admin::AdjustmentsController, type: :controller do
    include AuthenticationHelper

    before { controller_login_as_admin }

    describe "index" do
      let!(:order) { create(:order) }
      let!(:adjustment1) {
        create(:adjustment, originator_type: "Spree::ShippingMethod", order: order)
      }
      let!(:adjustment2) {
        create(:adjustment, originator_type: "Spree::PaymentMethod", eligible: false, order: order)
      }
      let!(:adjustment3) { create(:adjustment, originator_type: "EnterpriseFee", order: order) }

      it "loads all eligible adjustments" do
        spree_get :index, order_id: order.number

        expect(assigns(:collection)).to include adjustment1, adjustment3
        expect(assigns(:collection)).to_not include adjustment2
      end
    end

    describe "setting included tax" do
      let(:order) { create(:order) }
      let(:tax_rate) { create(:tax_rate, amount: 0.1, calculator: ::Calculator::DefaultTax.new) }

      describe "creating an adjustment" do
        it "sets included tax to zero when no tax rate is specified" do
          spree_post :create, order_id: order.number, adjustment: { label: 'Testing included tax', amount: '110' }, tax_rate_id: ''
          expect(response).to redirect_to spree.admin_order_adjustments_path(order)

          a = Adjustment.last
          expect(a.label).to eq('Testing included tax')
          expect(a.amount).to eq(110)
          expect(a.included_tax).to eq(0)
          expect(a.order_id).to eq(order.id)

          expect(order.reload.total).to eq 110
        end

        it "calculates included tax when a tax rate is provided" do
          spree_post :create, order_id: order.number, adjustment: { label: 'Testing included tax', amount: '110' }, tax_rate_id: tax_rate.id.to_s
          expect(response).to redirect_to spree.admin_order_adjustments_path(order)

          a = Adjustment.last
          expect(a.label).to eq('Testing included tax')
          expect(a.amount).to eq(110)
          expect(a.included_tax).to eq(10)
          expect(a.order_id).to eq(order.id)

          expect(order.reload.total).to eq 110
        end
      end

      describe "updating an adjustment" do
        let(:adjustment) {
          create(:adjustment, adjustable: order, order: order, amount: 1100, included_tax: 100)
        }

        it "sets included tax to zero when no tax rate is specified" do
          spree_put :update, order_id: order.number, id: adjustment.id, adjustment: { label: 'Testing included tax', amount: '110' }, tax_rate_id: ''
          expect(response).to redirect_to spree.admin_order_adjustments_path(order)

          a = Adjustment.last
          expect(a.label).to eq('Testing included tax')
          expect(a.amount).to eq(110)
          expect(a.included_tax).to eq(0)
          expect(a.order_id).to eq(order.id)

          expect(order.reload.total).to eq 110
        end

        it "calculates included tax when a tax rate is provided" do
          spree_put :update, order_id: order.number, id: adjustment.id, adjustment: { label: 'Testing included tax', amount: '110' }, tax_rate_id: tax_rate.id.to_s
          expect(response).to redirect_to spree.admin_order_adjustments_path(order)

          a = Adjustment.last
          expect(a.label).to eq('Testing included tax')
          expect(a.amount).to eq(110)
          expect(a.included_tax).to eq(10)
          expect(a.order_id).to eq(order.id)

          expect(order.reload.total).to eq 110
        end
      end
    end
  end
end
