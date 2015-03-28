require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  fixtures :patients, :invoices

  def setup
    @patient = patients(:max)
    @invoice = @patient.invoices.build(diagnosis: 'bad', totalfee: 100, invoicenumber: '1-1-1-1970', date: '1-1-1970', patient_id: @patient.id )
  end

  test "invoice should be valid" do
    assert @invoice.valid?
  end

  test "patient_id should be present" do
    @invoice.patient_id = nil
    assert_not @invoice.valid?
  end

  test "order should be most recent first" do
    assert_equal Invoice.first, invoices(:most_recent)
  end

  test "reject invalid invoice numbers" do
    invalid_invoicenumber = %w(a-1-1-1970 11-111-1-1970 11-11-111-1970 11-11-11-19701)
    invalid_invoicenumber.each do |invalidnumber|
      @invoice.invoicenumber = invalidnumber
      assert_not @invoice.valid?
    end
  end

  test "must have a date" do
    @invoice.date = nil
    assert_not @invoice.valid?
  end

end
