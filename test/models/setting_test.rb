require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @setting = Setting.new(title: 'Dr.',
                           firstname: 'Max',
                           lastname: 'Mustermann',
                           street: 'Musterstrasse 8',
                           zip: '1234',
                           city: 'Musterstadt',
                           email: 'max.mustermann@arzt.at',
                           phonenumber1: '01-1234567',
                           phonenumber2: '0664/1236845',
                           initial_receiptnumber: '123',
                           current_receiptnumber: '124',
                          )
  end

  test 'valid setting' do
    assert @setting.valid?
  end

  test 'firstname should be valid' do
    invalid_firstnames = [ ' Max', 'Max ', 'Max Moritz ', '123']
    invalid_firstnames.each do |firstname|
      @setting.firstname = firstname
      assert_not @setting.valid?, "'#{firstname}' should be an invalid firstname"
    end
  end

  test 'firstname should not be too long' do
    @setting.firstname = 'a' * 51
    assert_not @setting.valid?
  end

  test 'lastname should be valid' do
    invalid_lastnames = [ ' Mustermann', 'Mustermann ', 'Mustermann!', '123']
    invalid_lastnames.each do |lastname|
      @setting.lastname = lastname
      assert_not @setting.valid?, "'#{lastname}' should be an invalid lastname"
    end
  end

  test 'lastname should not be too long' do
    @setting.lastname = 'a' * 51
    assert_not @setting.valid?
  end
end
