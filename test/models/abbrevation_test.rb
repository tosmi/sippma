require 'test_helper'

class AbbrevationTest < ActiveSupport::TestCase
  def setup
    @abbrev = Abbrevation.new(abbrev: 'te',
                              text: 'this is a test abbrevation')
  end

  test "should be valid" do
    assert @abbrev.valid?
  end

  test "abbrev should be too long" do
    @abbrev.abbrev = 't' * 5
    assert_not @abbrev.valid?
  end

  test "text should not be too long" do
    @abbrev.text = 'a' * 256
    assert_not @abbrev.valid?
  end
end
