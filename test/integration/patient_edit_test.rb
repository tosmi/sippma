require 'test_helper'

class PatientEditTest < ActionDispatch::IntegrationTest

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

  test "unsuccessful edit" do
    get new_patient_path
    log_in_as(@admin)
    assert_redirected_to new_patient_path
    assert_difference 'Patient.count', 1 do
      post patients_path, @new_patient
    end
    patient = assigns(:patient)
    get edit_patient_path(patient)
    assert_select 'h1', 'Edit Patient'
    assert_select 'input[value=?]', patient.lastname
    @new_patient[:patient][:lastname] = ''
    patch patient_path(patient), @new_patient
    assert_template 'patients/edit'
    assert_not flash.empty?
  end

  test "successful edit" do
    get new_patient_path
    log_in_as(@admin)
    assert_redirected_to new_patient_path
    assert_difference 'Patient.count', 1 do
      post patients_path, @new_patient
    end
    patient = assigns(:patient)
    get edit_patient_path(patient)
    assert_select 'h1', 'Edit Patient'
    assert_select 'input[value=?]', patient.lastname
    @new_patient[:patient][:lastname] = 'Traurig'
    patch patient_path(patient), @new_patient
    assert_redirected_to patients_path
    follow_redirect!
    assert_not flash.empty?
    assert_match 'Traurig', response.body
  end

end
