require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    @admin = users(:admin)
    @new_patient_data = {
      patient: { firstname: 'Kurt',
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

    @new_patient_with_mother = {
      patient: {
        firstname: 'Patient',
        lastname: 'Lastname',
        zip: '1234',
        street: 'Teststrasse 8',
        city: 'Wien',
        ssn: '4321',
        insurance: 'WGKK',
        phonenumber1: '01 123456',
        phonenumber2: '01 654321',
        email: 'kurt@froehlich.at',
        birthdate: Date.today,
        mother: {
          firstname: 'Mother',
          lastname: 'Lastname',
          birthdate: '1.1.1970',
          ssn: '3333',
          insurance: 'NGKK',
        }
      }
    }


  end

  test "show welcome if there are no patients" do
    Patient.destroy_all
    get :index
    assert_redirected_to login_path
    log_in_as(@admin)
    get :index
    assert_template 'welcome'
  end

  test "create a new valid patient" do
    Patient.destroy_all
    get :index
    assert_redirected_to login_path
    log_in_as(@admin)
    get :index
    assert_template 'welcome'
    assert_difference 'Patient.count', 1 do
      post :create, params: @new_patient_data
    end
    get :index
    assert_template 'index'
  end

  test "does not save patient if invalid" do
    log_in_as(@admin)
    @new_patient_data[:patient][:firstname] = ''
    assert_no_difference 'Patient.count' do
      post :create, params: @new_patient_data
    end
  end

  test 'create new valid patient with mother' do
    Patient.destroy_all
    get :index
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_difference 'Patient.count', 2 do
      post :create, params: @new_patient_with_mother
    end
  end

  test 'does not save patient with invalid mother' do
    Patient.destroy_all
    get :index
    assert_redirected_to login_path
    log_in_as(@admin)
    @new_patient_with_mother[:patient][:mother][:ssn] = ''
    assert_no_difference 'Patient.count' do
      post :create, params: @new_patient_with_mother
    end
  end
end
