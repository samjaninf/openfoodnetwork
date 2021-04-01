class InvoiceRenderer
  def initialize(renderer = ApplicationController.new)
    @renderer = renderer
  end

  def render_to_string(order)
    renderer.instance_variable_set(:@order, order)
    renderer.render_to_string(args(order))
  end

  def args(order)
    {
      pdf: "invoice-#{order.number}.pdf",
      template: invoice_template,
      formats: [:html],
      encoding: "UTF-8"
    }
  end

  private

  attr_reader :renderer

  def invoice_template
    if Spree::Config.invoice_style2?
      "spree/admin/orders/invoice2"
    else
      "spree/admin/orders/invoice"
    end
  end
end
