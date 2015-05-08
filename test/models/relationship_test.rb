require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  fixtures :patients

  def setup
    @max = patients(:max)
    @silke = patients(:silke)
    @relationship = Relationship.new(parent_id: @silke.id, child_id: @max.id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require parent_id" do
    @relationship.parent_id = nil
    assert_not @relationship.valid?
  end

  test "should require child_id" do
    @relationship.child_id = nil
    assert_not @relationship.valid?
  end
end
