require 'test_helper'

class ConsultationNewTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
  end

  test "creating a new consultation" do
    get new_patient_consultation_path(@max)
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to new_patient_consultation_path(@max)
    assert_difference 'Consultation.count', 1 do
      post patient_consultations_path(@max), consultation: {
             diagnosis: 'test diagnosis',
             content: 'a diagnosis during testing'
           }
    end
    assert_redirected_to patients_path
  end

  test "reject creating an invalid consultation" do
    log_in_as(@admin)
    get new_patient_consultation_path(@max)
    assert_difference 'Consultation.count', 0 do
      post patient_consultations_path(@max), consultation: {
             diagnosis: '',
             content: 'a diagnosis during testing'
           }
    end
    assert_template 'consultations/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end
end
