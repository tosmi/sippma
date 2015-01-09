require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Max Musterman", email: "max@mustermann.com", password_digest: "", permissions: 1)
  end

  test "should be valid" do
    assert @user.valid?
  end
end
