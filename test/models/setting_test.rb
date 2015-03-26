require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @setting = Setting.instance
    @setting.update(title: 'Dr.',
                    firstname: 'Max',
                    lastname: 'Mustermann',
                    street: 'Musterstrasse 8',
                    zip: '1234',
                    city: 'Musterstadt',
                    email: 'max.mustermann@arzt.at',
                    phonenumber: '01-1234567',
                   )
  end

  test 'should not support creating a new setting' do
    assert_raises(NoMethodError) { Setting.new }
    assert_raises(NoMethodError) { Setting.create }
  end


  test 'valid setting' do
    assert @setting.valid?
  end

  test 'title should not be too long' do
    @setting.title = 'a' * 21
    assert_not @setting.valid?
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

  test 'city should not be too long' do
    @setting.city = 'a' * 51
    assert_not @setting.valid?
  end

  test 'street should not be too long' do
    @setting.street = 'a' * 51
    assert_not @setting.valid?
  end

  test "phonenumbers should not be too long" do
    @setting.phonenumber = "1"*31
    assert_not @setting.valid?
  end

  test "phonenumbers validation should only accept valid phonenumbers" do
    valid_phonenumbers = ['+43 664 123434',
                          '0043 664 123345',
                          '066412334556',
                          '0664/3234823',
                          '0664-34234281',
                          '01 28193 12818 12',]

    valid_phonenumbers.each do |phonenumber|
      @setting.phonenumber = phonenumber
      assert @setting.valid?, phonenumber
    end
  end

  test "phonenumbers validation should not accept invalid phonenumbers" do
    invalid_phonenumbers = ['+43 a664 123434',
                          '0043--664123345',
                          '0664//12334556',
                          '0664  234823', ]

    invalid_phonenumbers.each do |invalid_phonenumber|
      @setting.phonenumber = invalid_phonenumber
      assert_not @setting.valid?
    end
  end

  test "current_receiptnumber returns 1 if no initial_receiptnumber" do
    @setting.initial_receiptnumber = nil
    @setting.save

    assert_equal 1, Setting.next_receiptnumber
    assert_equal 2, Setting.next_receiptnumber
  end

  test "current_receiptnumber returns correct receiptnumber if initial_receiptnumber is set" do
    @setting.initial_receiptnumber = 100
    @setting.save

    assert_equal 100, Setting.next_receiptnumber
    assert_equal 101, Setting.next_receiptnumber
  end

end
