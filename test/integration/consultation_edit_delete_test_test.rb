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

  test "does not save if diagnosis is not valid" do
    log_in_as(@admin)
    get new_patient_consultation_path(@max)
    assert_difference 'Consultation.count', 0 do
      patch consultation_path(@first), consultation: {
             diagnosis: 'a' * 201,
           }
    end
    assert_template 'edit'
  end

  test "deleting a consultation" do
    assert_difference 'Consultation.count', 0 do
      delete consultation_path(@first)
    end
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_difference 'Consultation.count', -1 do
      delete consultation_path(@first)
    end
  end

end
