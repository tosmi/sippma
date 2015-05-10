require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @moritz   = patients(:moritz)
    @silke = patients(:silke)
  end

  test "adding a relationship" do
    assert_difference 'Relationship.count', 1 do
      post :create, patient_id: @moritz, relationship: {
             parent_id: @silke
           }
    end
    assert @moritz.child_of?(@silke)
    assert @silke.parent_of?(@moritz)
  end

end
