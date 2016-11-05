require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @admin = users(:admin)
  end

  test "login with invalid information" do
    get root_url
    assert_template 'sessions/new'
    post login_path, params: { session: { username: '', password: ''} }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?, "flash should not be empty"
    get login_url
    assert flash.empty?, "flash should be empty"
  end

  test "login with valid information" do
    get root_path
    post login_path, params: { session: { username: @admin.username, password: 'changeme' } }
    assert is_logged_in?
    assert_redirected_to patients_path
    follow_redirect!
    # if we acces the login page with a valid session cookie
    # we should get redirected to patients
    get root_path
    assert_redirected_to patients_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
  end

  test "unauthorized access should redirect to login" do
    get patients_path
    assert_redirected_to login_path
    follow_redirect!
    assert_match 'loginform', response.body
    log_in_as(@admin)
    follow_redirect!
    if Patient.any?
      assert_template 'patients/index'
    else
      assert_template 'patients/welcome'
    end
  end


end
