require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  fixtures :patients

  def setup
    @moritz = patients(:moritz)
    @silke = patients(:silke)
    @relationship = Relationship.new(parent_id: @silke.id, patient_id: @moritz.id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require parent_id" do
    @relationship.parent_id = nil
    assert_not @relationship.valid?
  end

  test "should require patient_id" do
    @relationship.patient_id = nil
    assert_not @relationship.valid?
  end

  test "should be unique" do
    the_same_relationship = Relationship.new(parent_id: @silke.id, patient_id: @moritz.id)
    @relationship.save
    assert_not the_same_relationship.valid?
  end
end
