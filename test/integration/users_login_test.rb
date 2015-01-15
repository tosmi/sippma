require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
  end

  test "login with invalid information" do
    get root_url
    assert_template 'sessions/new'
    post login_path, session: { username: '', password: ''}
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?, "flash should not be empty"
    get login_url
    assert flash.empty?, "flash should be empty"
  end

  test "login with valid information" do
    get root_path
    post login_path, session: { username: @admin.username, password: 'changeme' }
    assert is_logged_in?
    assert_redirected_to patients_path
    follow_redirect!
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
  end

end
