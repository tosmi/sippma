require 'test_helper'

class InvoicesListTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients, :invoices

  def setup
    @admin  = users(:admin)
    @max    = patients(:max)
    @moritz = patients(:moritz)
    @first  = invoices(:one)
  end

  test 'list invoices should work' do
    get patient_invoices_url(@max)
    assert_redirected_to login_url
    follow_redirect!
    log_in_as(@admin)
    assert_redirected_to patient_invoices_url(@max)
    follow_redirect!
    assert_template 'invoices/index'
    assert_select 'td', 'The First'
    assert_select 'td', 'The Second'
    assert_select 'td', 'The Third'
    assert_select 'a[href=?]', edit_invoice_path(@first)
    assert_select 'a[href=?]', invoice_path(@first), 2
    # the header includes one delete link (session)
    assert_select 'a[data-method=delete]', 4
  end


  test 'deleting an invoice should work' do
    get patient_invoices_url(@max)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to patient_invoices_url(@max)
    follow_redirect!
    assert_difference 'Invoice.count', -1 do
      delete invoice_path(@first)
    end
    assert_redirected_to patient_invoices_url(@max)
    assert_not flash.empty?
    assert_select 'div.alert', false, "Must not contain success flash after logout"
    assert_select 'div.alert-success', false, "Must not contain success flash after logout"
  end

  test 'successful edit' do
    get edit_invoice_path(@first)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to edit_invoice_path(@first)
    follow_redirect!
    diagnosis = 'changed'
    totalfee  = 500
    patch invoice_path(@first), params: {
      invoice: {
        diagnosis: diagnosis,
        totalfee: totalfee,
      }
    }
    assert_not flash.empty?
    assert_redirected_to patient_invoices_path(@max)
    @first.reload
    assert_equal @first.diagnosis, diagnosis
    assert_equal @first.totalfee, totalfee
  end

  test 'unsuccessful edit' do
    get edit_invoice_path(@first)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to edit_invoice_path(@first)
    follow_redirect!
    patch invoice_path(@first), params: {
      invoice: {
        diagnosis: ''
      }
    }
    assert_template 'invoices/edit'
    assert_not flash.empty?
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

end
