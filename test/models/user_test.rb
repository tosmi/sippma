require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "max",
                     fullname: "Max Musterman",
                     email: "max@mustermann.com",
                     password: "foobar",
                     password_confirmation: "foobar",
                     permissions: 1)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 21
    assert_not @user.valid?
  end

  test "username should only accept valid usernames"  do
    valid_usernames = %w[max max1 m1x]
    valid_usernames.each do |username|
      @user.username = username
      assert @user.valid?
    end
  end

  test "username should not accept invalid usernames" do
    invalid_usernames = %w[max_ "m x" " invalid"]
    invalid_usernames.each do |username|
      @user.username = username
      assert_not @user.valid?
    end
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?, "#{duplicate_user.username} is valid"
  end

  test "fullname should be present" do
    @user.fullname = ""
    assert_not @user.valid?
  end

  test "fullname should not be too long" do
    @user.fullname = "a" * 51
    assert_not @user.valid?
  end

  test "fullname should only accept valid fullnames" do
    valid_fullnames = ["Max Mustermann", "Margit von Musterfrau"]
    valid_fullnames.each do |fullname|
      @user.fullname = fullname
      assert @user.valid?, "'#{fullname}' not valid"
    end
  end

  test "fullname should not accept invalid fullnames" do
    invalid_fullnames = [" Max Mustermann", "Margit  von Musterfrau"]
    invalid_fullnames.each do |fullname|
      @user.fullname = fullname
      assert_not @user.valid?, "'#{fullname}' is valid"
    end
  end

  test "email should not be valid" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email should only accept valid emails" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "'#{email}' not valid"
    end
  end

  test "email should not accept invalid emails" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "'#{email}' is valid"
    end
  end

  test "email address should be saved as lower-case" do
    mixed_case_email = "Foo@ExAmPlE.cOm"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
