module Admin
  class InvoiceSettingsController < Spree::Admin::BaseController
    def update
      Spree::Config.set(preferences_params.to_h)

      respond_to do |format|
        format.html {
          redirect_to main_app.edit_admin_invoice_settings_path
        }
      end
    end

    private

    def preferences_params
      params.require(:preferences).permit(
        :enable_invoices?,
        :invoice_style2?,
        :enable_receipt_printing?,
      )
    end
  end
end
