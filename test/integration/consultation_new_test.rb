require 'test_helper'

class ConsultationNewTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients

  def setup
    @user = users(:admin)
    @max  = patients(:max)
  end

  test "creating a new consultation" do
    get new_patient_consultation_path(@max)
    assert_redirected_to login_path
    log_in_as(@user)
    assert_redirected_to new_patient_consultation_path(@max)
  end
end
