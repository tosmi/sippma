require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @admin = users(:admin)
  end

  test "creating a new user" do
    get users_path
    assert_redirected_to login_path
    log_in_as(@admin)
    get users_path
    assert_template :index
  end

  test "deleting a user" do
    get users_path
    assert_redirected_to login_path
    log_in_as(@admin)
    get users_path
    assert_template :index
  end


end
