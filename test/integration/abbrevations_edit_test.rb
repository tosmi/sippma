require 'test_helper'

class AbbrevationsEditTest < ActionDispatch::IntegrationTest
  fixtures :users, :abbrevations

  def setup
    @admin = users(:admin)
    @one   = abbrevations(:one)
  end

  test "successful editing an abbrevation" do
    get edit_abbrevation_path(@one)
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to edit_abbrevation_path(@one)
    follow_redirect!
    assert assigns(:abbrevation)
    assert_template 'abbrevations/edit'
    patch abbrevation_path(@one), params: { abbrevation: { text: 'Anton Paul Schmidbauer' } }
    assert_redirected_to abbrevations_path
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'div.alert-success'
    @one.reload
    assert_equal @one.text, 'Anton Paul Schmidbauer'
  end

  test "unsucessful editing an abbrevation" do
    get edit_abbrevation_path(@one)
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to edit_abbrevation_path(@one)
    follow_redirect!
    assert assigns(:abbrevation)
    assert_template 'abbrevations/edit'
    patch abbrevation_path(@one), params: { abbrevation: { text: '' } }
    assert_template 'abbrevations/edit'
    assert_not flash.empty?
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

end
