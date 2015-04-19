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
    assert_select 'td', 'The First'
    assert_select 'td', 'The Second'
    assert_select 'td', 'The Third'
    assert_select 'a[href=?]', edit_invoice_path(@first)
    assert_select 'a[href=?]', invoice_path(@first)
  end

end
