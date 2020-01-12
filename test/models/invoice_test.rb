require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  fixtures :patients, :invoices

  def setup
    @patient = patients(:max)
    @invoice = @patient.invoices.build(diagnosis: 'bad', totalfee: 100, invoicenumber: '01-01-01-70', date: '1-1-1970', consultation_date: '1-1-1970', patient_id: @patient.id )
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

  test "consultation date should be present" do
    @invoice.consultation_date = nil
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

  test "accepts valid invoice numbers" do
    valid_invoicenumbers = %w(1-01-01-70 10-02-02-80 100-03-03-99 1000-04-04-40)
    valid_invoicenumbers.each do |invoicenumber|
      @invoice.invoicenumber = invoicenumber
      assert @invoice.valid?, "Invoicenumber #{invoicenumber} should be valid"
    end
  end

  test "reject invalid invoice numbers" do
    invalid_invoicenumbers = %w(a-1-1-1970 11-111-1-1970 11-11-111-1970 11-11-11-19701)
    invalid_invoicenumbers.each do |invalidnumber|
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
        consultation_date: '1-1-1970',
        entry_lines_attributes: [
          { text: 'first', amount: '1'},
          { text: 'first', amount: '2'},
        ])
    end

  end


end
