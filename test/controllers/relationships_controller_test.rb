require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @max   = patients(:max)
    @silke = patients(:silke)
  end

  test "adding a relationship" do
    assert_difference 'Relationship.count', 1 do
      post :create, patient_id: @max, relationship: {
             parent_id: @silke
           }
    end
    assert @max.child_of?(@silke)
    assert @silke.parent_of?(@max)
  end

end
