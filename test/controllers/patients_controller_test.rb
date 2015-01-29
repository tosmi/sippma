require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    @admin = users(:admin)
    @new_patient_data = { patient: { firstname: 'Kurt',
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
      post :create, @new_patient_data
    end
    get :index
    assert_template 'index'
  end

  test "does not save patient if invalid" do
    log_in_as(@admin)
    @new_patient_data[:patient][:firstname] = ''
    assert_no_difference 'Patient.count' do
      post :create, @new_patient_data
    end
  end

end
