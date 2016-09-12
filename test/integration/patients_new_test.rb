require 'test_helper'

class PatientNewTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients


  def setup
    @admin = users(:admin)
    @max   = patients(:max)
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
                                birthdate: 5.years.ago
                              }
                   }
  end

  test "create a new patient" do
    get new_patient_path
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to new_patient_path
    follow_redirect!
    assert_template 'patients/new'
    assert_template 'patients/_parent_search_modal'
    assert_difference 'Patient.count', 1 do
      post patients_path, params: @new_patient
    end
    assert_redirected_to patients_url
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'div.alert-success', { :count => 1, :text => 'Successfully saved new patient' }
    assert_select 'td', 'Kurt'
    assert_select 'td', 'Froehlich'
    assert_select 'td', '1234 Wien, Teststrasse 8'
    assert_select 'td', /4321 /
    assert_select 'div.btn-toolbar'
    delete logout_path
    follow_redirect!
    assert_select 'div.alert', false, "Must not contain success flash after logout"
    assert_select 'div.alert-success', false, "Must not contain success flash after logout"
  end

  test "reject creating an invalid patient" do
    get new_patient_path
    log_in_as(@admin)
    assert_redirected_to new_patient_path
    assert_no_difference 'Patient.count' do
      @new_patient[:patient][:firstname] = ''
      post patients_path, params: @new_patient
    end
    assert_template 'patients/new'
    assert_template 'patients/_parent_search_modal'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "deleting a patient" do
    log_in_as(@admin)
    follow_redirect!
    assert_select 'td', 'Max'
    assert_difference 'Patient.count', -1 do
      delete patient_path(@max)
    end
  end


end
