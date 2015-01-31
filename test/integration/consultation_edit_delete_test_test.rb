require 'test_helper'

class ConsultationEditDeleteTestTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients, :consultations

  def setup
    @admin = users(:admin)
    @max = patients(:max)
    @first = consultations(:first)
  end

  test "edit a consultation" do
    get edit_consultation_path(@first)
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to edit_consultation_path(@first)
    patch consultation_path(@first), consultation: {
            diagnosis: 'another diagnosis'
          }
    assert_redirected_to patient_consultations_path(@max)
    follow_redirect!
    assert_match 'another diagnosis', response.body
  end

end
