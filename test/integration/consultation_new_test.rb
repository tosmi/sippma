require 'test_helper'

class ConsultationNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin)
  end

  test "creating a new consultation" do
    get new_patient_consultation_path
    assert_redirected_to login_path
    log_in_as(@user)
    assert_redirected_to new_patient_consultation_path
  end
end
