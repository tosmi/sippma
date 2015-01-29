require 'test_helper'

class PatientIndexTest < ActionDispatch::IntegrationTest
  fixtures :users, :patients, :consultations

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
  end

  test "show patients index" do
    get patients_path
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_redirected_to patients_path
    follow_redirect!
    assert_select 'td', 'Max'
    assert_select 'td', 'Mustermann'
    assert_select 'div.btn-toolbar'
    assert_select 'a[href=?]', new_patient_consultation_path(@max)
    assert_select 'a[href=?]', patient_consultations_path(@max)
    assert_select 'a[href=?]', patient_path(@max)
    assert_select 'a[href=?]', edit_patient_path(@max)
    assert_select 'a[href=?][data-method=delete]', patient_path(@max)

  end

  test "show patient details" do
    log_in_as(@admin)
    get patient_path(@max)
    assert_match 'Max Mustermann', response.body
    assert_select 'a[href=?]', patients_path
    assert_select 'a[href=?]', edit_patient_path(@max)
  end

end
