# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::TaxSettingsController, type: :controller do
  describe "#update" do
    let(:params) {
      {
        preferences: {
          products_require_tax_category: "1",
          shipment_inc_vat: "0",
          shipping_tax_rate: "0.1",
        }
      }
    }

    before do
      allow(controller).to receive(:spree_current_user) { create(:admin_user) }
    end

    it "changes Tax settings" do
      expect {
        spree_post :update, params
      }.to change {
        [
          Spree::Config[:products_require_tax_category],
          Spree::Config[:shipment_inc_vat],
          Spree::Config[:shipping_tax_rate],
        ]
      }.to(
        [
          true,
          false,
          0.1,
        ]
      )
    end
  end
end
