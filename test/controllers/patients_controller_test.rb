require 'test_helper'

class PatientsControllerTest < ActionController::TestCase

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

  test "show welcome if there are no patients" do
    get :index
    if not Patient.any?
      assert_template 'welcome'
    else
      assert_template 'index'
    end
  end

  test "create a new valid patient" do
    assert_difference 'Patient.count', 1 do
      post :create, @new_patient
    end
  end

  test "does not save patient if invalid" do
    @new_patient[:patient][:firstname] = ''
    assert_no_difference 'Patient.count' do
      post :create, @new_patient
    end
  end

end
