require 'test_helper'

class PatientIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = User.find_by username: 'admin'
    @patient_params = {
      patient: {
        firstname: 'First',
        lastname: 'Record',
        zip: '6666',
        street: 'Recordstreet 8',
        city: 'New York',
        ssn: '4321',
        insurance: 'WGKK',
        phonenumber1: '01 123456',
        phonenumber2: '01 654321',
        email: 'first@record.com',
        birthdate: Date.today,
      }
    }
  end

  test "creating the first patient record" do
    get patients_path
    assert_redirected_to login_path
    log_in_as(@admin)
    follow_redirect!
    assert_match "Welcome to SIPPMA", response.body
    assert_select "a[href=?]", new_patient_path
    get new_patient_path
    assert_difference 'Patient.count', 1 do
      post patients_path, @patient_params
    end
    follow_redirect!
    assert_select 'div.alert-success', { :count => 1, :text => 'Successfully saved new patient' }
    assert_select 'td', 'First'
    assert_select 'td', 'Record'
    assert_select 'td', '6666 New York, Recordstreet 8'
    assert_select 'div.btn-toolbar'
  end

  test "deleting a patient" do
    log_in_as(@admin)
    assert_difference 'Patient.count', 1 do
      post patients_path, @patient_params
    end
    patient = assigns(:patient)
    assert patient
    follow_redirect!
    assert_select 'td', 'First'
    assert_difference 'Patient.count', -1 do
      delete patient_path(patient)
    end
  end

  test "show patient details" do
    log_in_as(@admin)
    assert_difference 'Patient.count', 1 do
      post patients_path, @patient_params
    end
    patient = assigns(:patient)
    follow_redirect!
    assert_select 'a[href=?]', patient_path(patient)
    get patient_path(patient)
    assert_match 'First Record', response.body
    assert_match '6666 New York, Recordstreet 8', response.body
    assert_select 'a[href=?]', patients_path
    assert_select 'a[href=?]', edit_patient_path(patient)
  end

end
