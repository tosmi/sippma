require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get root_url
    assert_template 'sessions/new'
    post login_path, session: { username: '', password: ''}
    assert_template 'sessions/new'
    assert_not flash.empty?, "flash should not be empty"
    get login_url
    assert flash.empty?, "flash should be empty"
  end

  test "login with valid information" do
    get root_path
    post login_path, session: { username: 'admin', password: 'changeme' }
    assert_select "h1", "logged in"
  end
end
