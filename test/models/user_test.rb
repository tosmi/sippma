require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "max", fullname: "Max Musterman", email: "max@mustermann.com", password_digest: "", permissions: 1)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "fullname should be present" do
    @user.fullname = ""
    assert_not @user.valid?
  end

  test "email should not be valid" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "fullname should not be too long" do
    @user.fullname = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end
end
