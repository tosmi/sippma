require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  fixtures :patients, :invoices

  def setup
    @patient = patients(:max)
    @invoice = @patient.invoices.build(diagnosis: 'bad', totalfee: 100, invoicenumber: '01-01-01-70', date: '1-1-1970', patient_id: @patient.id )
  end

  test "invoice should be valid" do
    assert @invoice.valid?
  end

  test "patient_id should be present" do
    @invoice.patient_id = nil
    assert_not @invoice.valid?
  end

  test "totalfee should be present" do
    @invoice.totalfee = nil
    assert_not @invoice.valid?
  end

  test "date should be present" do
    @invoice.date = nil
    assert_not @invoice.valid?
  end

  test "invoicenumber should be present" do
    @invoice.invoicenumber = nil
    assert_not @invoice.valid?
  end

  test "diagnosis should be present" do
    @invoice.diagnosis = nil
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


  test "building an invoice with entry lines works" do
    assert_difference 'EntryLine.count', 2 do
      @invoice = @patient.invoices.create!(diagnosis: 'very bad',
                                         totalfee: '200',
                                         invoicenumber: '02-01-01-70',
                                         date: '1-1-1970',
                                         entry_lines_attributes: [
                                           { text: 'first', fee: '100'},
                                           { text: 'first', fee: '200'},
                                         ])
    end

  end


end
