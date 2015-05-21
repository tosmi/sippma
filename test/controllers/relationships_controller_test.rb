require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  fixtures :users, :patients

  def setup
    @admin = users(:admin)
    @moritz   = patients(:moritz)
    @silke = patients(:silke)
  end

  test "adding a relationship" do
    post :create, patient_id: @moritz, relationship: {
           parent_id: @silke
         }
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_difference 'Relationship.count', 1 do
      post :create, patient_id: @moritz, relationship: {
             parent_id: @silke
           }
    end
    assert @moritz.child_of?(@silke)
    assert @silke.parent_of?(@moritz)
  end

  test "saving an invalid relationship do" do
    log_in_as(@admin)
    assert_difference 'Relationship.count', 1 do
      post :create, patient_id: @moritz, relationship: {
             parent_id: @silke
           }
    end
    assert_difference 'Relationship.count', 0 do
      post :create, patient_id: @moritz, relationship: {
             parent_id: @silke
           }
    end
  end

end
