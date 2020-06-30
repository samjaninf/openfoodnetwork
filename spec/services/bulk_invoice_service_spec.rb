require 'spec_helper'

describe BulkInvoiceService do
  let(:service) { BulkInvoiceService.new }

  describe "#start_pdf_job" do
    it "starts a background process to create a pdf with multiple invoices" do
      expect do
        service.start_pdf_job [1, 2]
      end.to enqueue_job Delayed::PerformableMethod

      expect(Delayed::Job.last.payload_object.method_name).to eq :start_pdf_job_without_delay
    end

    it "creates a PDF invoice" do
      order = create(:completed_order_with_fees)
      order.bill_address = order.ship_address
      order.save!

      service.start_pdf_job_without_delay([order.id])

      expect(service.invoice_created?(service.id)).to be_truthy
    end
  end

  describe "#invoice_created?" do
    context "when the invoice has been created" do
      it "returns true" do
        allow(File).to receive(:exist?).and_return(true)

        created = service.invoice_created? '45891723'
        expect(created).to be_truthy
      end
    end

    context "when the invoice has not been created" do
      it "returns false" do
        created = service.invoice_created? '1234567'
        expect(created).to_not be_truthy
      end
    end
  end

  describe "#filepath" do
    it "returns the filepath of a given invoice" do
      filepath = service.filepath '1234567'
      expect(filepath).to eq 'tmp/invoices/1234567.pdf'
    end
  end

  describe "#orders_from" do
    let(:renderer) { InvoiceRenderer.new }

    before do
      allow(InvoiceRenderer).to receive(:new).and_return(renderer)
    end

    it "orders with completed desc" do
      order_old = create(:order_with_distributor, :completed, completed_at: 2.minutes.ago)
      order_oldest = create(:order_with_distributor, :completed, completed_at: 4.minutes.ago)
      order_older = create(:order_with_distributor, :completed, completed_at: 3.minutes.ago)

      expect(renderer).to receive(:render_to_string).with(order_old).ordered.and_return("")
      expect(renderer).to receive(:render_to_string).with(order_older).ordered.and_return("")
      expect(renderer).to receive(:render_to_string).with(order_oldest).ordered.and_return("")

      order_ids = [order_oldest, order_old, order_older].map(&:id)
      service.start_pdf_job_without_delay(order_ids)
    end
  end
end
