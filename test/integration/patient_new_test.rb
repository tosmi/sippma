require 'test_helper'

class PatientNewTest < ActionDispatch::IntegrationTest

  def setup
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
    assert_template 'patients/new'
    assert_difference 'Patient.count', 1 do
      post patients_path, @new_patient
    end
    assert_redirected_to patients_url
    follow_redirect!
    assert_template 'patients/index'
  end

  test "reject invalid patient" do
    get new_patient_path
    assert_template 'patients/new'
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
