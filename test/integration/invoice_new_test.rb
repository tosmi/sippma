require 'test_helper'

class InvoiceNewTestTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
    @moritz  = patients(:moritz)
  end

  test "patient has link to new invoice" do
    get patients_url(@max)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to patients_path(@max)
    follow_redirect!
    assert_select 'a[href=?]', new_patient_invoice_path(@moritz)
  end

  test "create a new invoice for patient with consultation" do
    get new_patient_invoice_url(@max)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to new_patient_invoice_url(@max)
    follow_redirect!
    get new_patient_invoice_url(@max)
    assert_template 'invoices/new'
  end

  test "create a new invoice for patient without consultation" do
    get new_patient_invoice_url(@moritz)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to new_patient_invoice_url(@moritz)
    follow_redirect!
    get new_patient_invoice_url(@moritz)
    assert_template 'invoices/new'
  end

  test "invoicenumber only changes on save"  do
    get new_patient_invoice_url(@max)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to new_patient_invoice_url(@max)
    follow_redirect!
    rno1 = assigns(:invoicenumber)
    get new_patient_invoice_url(@max)
    rno2 = assigns(:invoicenumber)
    assert_equal rno1,rno2
  end

end
