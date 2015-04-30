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
    assert_template 'patients/_parent_search_modal'
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
    street = 'Mustergasse 9'
    patch patient_path(@max), patient: {
            firstname: @max.firstname,
            lastname: @max.lastname,
            birthdate: @max.birthdate,
            ssn: @max.ssn,
            zip: @max.zip,
            city: @max.city,
            phonenumber1: @max.phonenumber1,
            phonenumber2: @max.phonenumber2,
            email: @max.email,
            street: 'Mustergasse 9' }
    assert_redirected_to patients_path
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'div.alert-success'
    @max.reload
    assert_equal @max.street, street
  end

end
