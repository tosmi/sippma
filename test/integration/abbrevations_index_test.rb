require 'test_helper'

class AbbrevationsIndexTest < ActionDispatch::IntegrationTest
  fixtures :users, :abbrevations

  def setup
    @admin = users(:admin)
    @one   = abbrevations(:one)
  end

  test "should show welcome if no abbrevations" do
    Abbrevation.delete_all
    get abbrevations_path
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to abbrevations_path
    follow_redirect!
    assert_template 'welcome'
    assert_select 'a[href=?]', new_abbrevation_path
    assert_match 'no abbrevations', response.body
  end

  test "should show abbrevation list if there are any" do
    get abbrevations_path
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to abbrevations_path
    follow_redirect!
    assert_template 'index'
    assert_select 'th', 'Abbrevation'
    assert_select 'th', 'Text'
    assert_select 'a[href=?]', edit_abbrevation_path(@one)
    assert_select 'a[href=?]', abbrevation_path(@one), 'Delete'
  end

end
