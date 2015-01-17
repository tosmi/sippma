require 'test_helper'

class PatientTest < ActiveSupport::TestCase

  def setup
    @patient = Patient.create!(firstname: 'Max',
                           lastname: 'Mustermann',
                           email: 'max@mustermann.at',
                           birthdate: Date.today,
                           zip: '1234',
                           city: 'Gotham',
                           street: 'Teststreet 3/8',
                           phonenumber1: '0664/123456',
                           phonenumber2: '0676-123456',
                           ssn: '1234',
                           insurance: 'GG')
  end

  test "should be valid?" do
    assert @patient.valid?
  end

  test "firstname/lastname should not be too long" do
    @patient.firstname = "a"*51
    @patient.lastname = "a"*51
    assert_not @patient.valid?
  end

  test "firstname/lastname should be present" do
    @patient.firstname = ""
    @patient.lastname = ""
  end

  test "firstname/lastname should only accept valid firstnames/lastnames" do
    valid_names = ['Max Friedrich Heinrich', 'Max Friedrich']
    valid_names.each do |name|
      @patient.firstname = name
      @patient.lastname = name
      assert @patient.valid?
    end
  end

  test "firstname/lastname should not accept invalid firstnames/lastnames" do
    valid_names = ['1ax Friedrich', '!Max', 'Max  Anton', 'Max Anton ']
    valid_names.each do |name|
      @patient.firstname = name
      @patient.lastname = name
      assert_not @patient.valid?, name
    end
  end

  test "zip should not be too long" do
    @patient.zip = "1"*6
    assert_not @patient.valid?
  end

  test "zip should only accept valid zip codes" do
    valid_zip_codes = %w[1 12 123 1234 12345]
    valid_zip_codes.each do |zip|
      @patient.zip = zip
      assert @patient.valid?
    end
  end

  test "zip should no accept invalid zip codes" do
    invalid_zip_codes = %w[123456 a1234 12a34 1234ab]
    invalid_zip_codes.each do |zip|
      @patient.zip = zip
      assert_not @patient.valid?
    end
  end

  test "phonenumbers should not be too long" do
    @patient.phonenumber1 = "1"*31
    assert_not @patient.valid?
  end

  test "phonenumbers should only accept valid phonenumbers" do
    valid_phonenumbers = ['+43 664 123434',
                          '0043 664 123345',
                          '066412334556',
                          '0664/3234823',
                          '0664-34234281',
                          '01 28193 12818 12',]

    valid_phonenumbers.each do |phonenumber|
      @patient.phonenumber1 = phonenumber
      assert @patient.valid?, phonenumber
    end
  end

  test "phonenumbers should not accept invalid phonenumbers" do
    invalid_phonenumbers = ['+43 a664 123434',
                          '0043--664123345',
                          '0664//12334556',
                          '0664  234823', ]

    invalid_phonenumbers.each do |invalid_phonenumber|
      @patient.phonenumber1 = invalid_phonenumber
      assert_not @patient.valid?
    end
  end

  test "insurance should not be too long" do
    @patient.insurance = "a"*51
    assert_not @patient.valid?
  end

  test "insurance should be present" do
    @patient.insurance = ""
  end

  test "insurance should only accept a valid insurance name" do
    valid_names = ['WGKK', 'Wiener Gebietskrankenkasse', 'Krankenkasse',]
    valid_names.each do |name|
      @patient.insurance = name
      assert @patient.valid?
    end
  end

  test "insurance should not accept invalid insurance name" do
    valid_names = ['!WGKK', '1XYZ', 'Test  Krankenkasse']
    valid_names.each do |name|
      @patient.insurance = name
      assert_not @patient.valid?, name
    end
  end

  test "ssn should not be too long" do
    @patient.ssn = "1"*6
    assert_not @patient.valid?
  end

  test "ssn should only accept valid ssn codes" do
    valid_ssn_codes = %w[1 12 123 1234 12345]
    valid_ssn_codes.each do |ssn|
      @patient.ssn = ssn
      assert @patient.valid?
    end
  end

  test "ssn should no accept invalid ssn codes" do
    invalid_ssn_codes = %w[123456 a1234 12a34 1234ab]
    invalid_ssn_codes.each do |ssn|
      @patient.ssn = ssn
      assert_not @patient.valid?, ssn
    end
  end

  test "email should not be valid" do
    @patient.email = "  "
    assert_not @patient.valid?
  end

  test "email should not be too long" do
    @patient.email = "a" * 256
    assert_not @patient.valid?
  end

  test "email should only accept valid emails" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |email|
      @patient.email = email
      assert @patient.valid?, "'#{email}' not valid"
    end
  end

end
