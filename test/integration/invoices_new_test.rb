require 'test_helper'

class InvoiceNewTestTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
    @moritz  = patients(:moritz)
    @new_invoice_data = {
      invoice: {
        diagnosis: 'a test',
        invoicenumber: '66-30-01-14',
        date: '30-01-14,',
        consultation_date: '30-01-14,',
        totalfee: 300,
        entry_lines_attributes: [
          {
            text: 'first',
            amount: '1',
          },
          {
            text: 'second',
            amount: '2',
          }
        ]
      }
    }

    @invalid_invoice_data = { invoice:
      {
        diagnosis: 'does not work',
        invoicenumber: 'wrong',
        date: Date.today,
        consultation_date: Date.today
      }
    }
  end

  test "create new invoice for patient with consultation" do
    get new_patient_invoice_url(@max)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to new_patient_invoice_url(@max)
    follow_redirect!
    assert_template 'invoices/new'
    assert_select ":match('id',?)", /invoice_entry_lines_attributes_\d+_text/
    # assert_select ":match('id',?)", /invoice_entry_lines_attributes_\d+_fee/
    assert_difference 'Invoice.count', 1 do
      post patient_invoices_path(@max), params: @new_invoice_data
    end
    invoice = assigns[:invoice]
    assert_redirected_to invoice_url(invoice.id)
    follow_redirect!
    assert_template 'invoices/show'
    assert_select 'div.alert'
    assert_select 'div.alert-success', { :count => 1, :text => 'Invoice successfully saved'}
  end

  test "does not save an invalid invoice" do
    get new_patient_invoice_url(@moritz)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to new_patient_invoice_url(@moritz)
    follow_redirect!
    assert_template 'invoices/new'
    assert_difference 'Invoice.count', 0 do
      post patient_invoices_path(@max), params: @invalid_invoice_data
    end
    assert_template 'invoices/new'
    assert_select 'div.alert'
    assert_select "input[type=hidden][name='invoice[invoicenumber]']"
    assert_select "input[type=hidden][name='invoice[date]']"
    assert_select 'div.alert-danger', { :count => 1, :text => /form.*error/ }
    assert_select ":match('id',?)", /invoice_entry_lines_attributes_\d+_text/
    # assert_select ":match('id',?)", /invoice_entry_lines_attributes_\d+_fee/
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
