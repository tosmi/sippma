require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  fixtures :patients, :receipts

  def setup
    @patient = patients(:max)
    @receipt = @patient.receipts.build(diagnosis: 'bad', totalfee: 100, receiptnumber: '1-1-1-1970', date: '1-1-1970', patient_id: @patient.id )
  end

  test "receipt should be valid" do
    assert @receipt.valid?
  end

  test "patient_id should be present" do
    @receipt.patient_id = nil
    assert_not @receipt.valid?
  end

  test "order should be most recent first" do
    assert_equal Receipt.first, receipts(:most_recent)
  end

  test "reject invalid receipt numbers" do
    invalid_receiptnumber = %w(a-1-1-1970 11-111-1-1970 11-11-111-1970 11-11-11-19701)
    invalid_receiptnumber.each do |invalidnumber|
      @receipt.receiptnumber = invalidnumber
      assert_not @receipt.valid?
    end
  end

  test "must have a date" do
    @receipt.date = nil
    assert_not @receipt.valid?
  end

end
