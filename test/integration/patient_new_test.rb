require 'test_helper'

class PatientNewTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @new_patient = { patient: { firstname: 'Kurt',
                                lastname: 'Froehlich',
                                zip: '1234',
                                street: 'Teststrasse 8',
                                city: 'Wien',
                                ssn: '4321',
                                insurance: 'WGKK',
                                phonenumber1: '01 123456',
                                phonenumber2: '01 654321',
                                email: 'kurt@froehlich.at',
                                birthdate: Date.today,
                              }
                   }
  end

  test "create a new patient" do
    get new_patient_path
    log_in_as(@admin)
    assert_redirected_to new_patient_path
    assert_difference 'Patient.count', 1 do
      post patients_path, @new_patient
    end
    assert_redirected_to patients_url
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'div.alert-success'
    delete logout_path
    follow_redirect!
    assert_select 'div.alert', false, "Must not contain success flash after logout"
    assert_select 'div.alert-success', false, "Must not contain success flash after logout"
  end

  test "reject invalid patient" do
    get new_patient_path
    log_in_as(@admin)
    assert_redirected_to new_patient_path
    assert_no_difference 'Patient.count' do
      @new_patient[:patient][:firstname] = ''
      post patients_path, @new_patient
    end
    assert_template 'patients/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

end
