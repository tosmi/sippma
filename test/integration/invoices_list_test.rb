require 'test_helper'

class InvoicesListTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin  = users(:admin)
    @max    = patients(:max)
    @moritz = patients(:moritz)
  end

  test 'list invoices should work' do
    get patient_invoices_url(@max)
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to patient_invoices_url(@max)
    follow_redirect!
  end

end
