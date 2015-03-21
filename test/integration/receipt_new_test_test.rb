require 'test_helper'

class ReceiptNewTestTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
  end

  test "create a new receipt" do
    get patients_url
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to patients_url
    follow_redirect!
    assert_select 'a[href=?]', new_patient_receipt_path(@max)
    get new_patient_receipt_url(@max)

  end

end