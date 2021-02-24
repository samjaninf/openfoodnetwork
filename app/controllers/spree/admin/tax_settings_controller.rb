module Spree
  module Admin
    class TaxSettingsController < Spree::Admin::BaseController
      def update
        Spree::Config.set(preferences_params.to_h)

        respond_to do |format|
          format.html {
            redirect_to spree.edit_admin_tax_settings_path
          }
        end
      end

      private

      def preferences_params
        params.require(:preferences).permit(
          :products_require_tax_category,
          :shipment_inc_vat,
          :shipping_tax_rate,
        )
      end
    end
  end
end
