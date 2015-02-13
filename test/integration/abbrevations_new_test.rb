require 'test_helper'

class AbbrevationsNewTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @admin = users(:admin)
  end

  test "sucessfully creating a new abbrevation" do
    get new_abbrevation_path
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to new_abbrevation_path
    follow_redirect!
    assert_select 'form input', 4
    assert_select 'input[name^=abbrev]', 2
    assert_difference 'Abbrevation.count', 1 do
      post abbrevations_path, abbrevation: {
             abbrev: 'it',
             text: 'Integration Test',
           }
    end
    assert_redirected_to abbrevations_path
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'div.alert-success', { :count => 1, :text => 'Successfully created new abbrevation.' }
    assert_select 'td', 'it'
    assert_select 'td', 'Integration Test'
    delete logout_path
    follow_redirect!
    assert_select 'div.alert', false, "Must not contain success flash after logout"
    assert_select 'div.alert-success', false, "Must not contain success flash after logout"
  end

  test "reject creating an invalid abbrevation" do
    get new_abbrevation_path
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to new_abbrevation_path
    follow_redirect!
    assert_select 'form input', 4
    assert_select 'input[name^=abbrev]', 2
    assert_difference 'Abbrevation.count', 0 do
      post abbrevations_path, abbrevation: {
             abbrev: '',
             text: 'Integration Test',
           }
    end
    assert_template 'abbrevations/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

end
