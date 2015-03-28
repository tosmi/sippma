require 'test_helper'

class InvoiceNewTestTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
  end

  test "create a new invoice" do
    get patients_url
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to patients_url
    follow_redirect!
    assert_select 'a[href=?]', new_patient_invoice_path(@max)
    get new_patient_invoice_url(@max)
    assert_template 'invoices/new'
  end

  test "invoicenumber only changes on save"  do
    get patients_url
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to patients_url
    follow_redirect!
    get new_patient_invoice_url(@max)
    rno1 = assigns(:invoicenumber)
    get new_patient_invoice_url(@max)
    rno2 = assigns(:invoicenumber)
    assert_equal rno1,rno2
  end


end
