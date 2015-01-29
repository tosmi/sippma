require 'test_helper'

class PatientEditTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
  end

  test "unsuccessful edit" do
    get edit_patient_path(@max)
    log_in_as(@admin)
    assert_redirected_to edit_patient_path(@max)
    follow_redirect!
    assert_select 'h1', 'Edit Patient'
    assert_select 'input[value=?]', @max.lastname
    @max.lastname = ''
    patch patient_path(@max), patient: { street: '' }
    assert_template 'patients/edit'
    assert_not flash.empty?
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "successful edit" do
    get edit_patient_path(@max)
    log_in_as(@admin)
    assert_redirected_to edit_patient_path(@max)
    follow_redirect!
    assert_select 'h1', 'Edit Patient'
    assert_select 'input[value=?]', @max.lastname
    @max.lastname = ''
    patch patient_path(@max), patient: { street: 'Mustergasse 9' }
    follow_redirect!
    assert_template 'patients/index'
    assert_not flash.empty?
    assert_select 'div.alert'
    assert_select 'div.alert-success'
  end

end
