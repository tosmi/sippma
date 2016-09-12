require 'test_helper'

class AbbrevationsControllerTest < ActionController::TestCase
  fixtures :users, :abbrevations

  def setup
    @admin = users(:admin)
    @one   = abbrevations(:one)
  end

  test "should return ok if format html" do
    log_in_as(@admin)
    get :index, format: :html
    assert_response :success
    assert_not_nil assigns(:abbrevations)
  end

  test "should return ok if format json" do
    log_in_as(@admin)
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:abbrevations)
    assert_match %r[application/json], response.header["Content-Type"]
    assert JSON.parse(response.body)
  end

  test "should return empty json list if no abbrevations" do
    log_in_as(@admin)
    Abbrevation.delete_all
    get :index, format: :json
    assert_response :success
    assert JSON.parse(response.body)
  end

  test "creating a new abbrevation" do
    log_in_as(@admin)
    assert_difference 'Abbrevation.count', 1 do
      post :create, params: {
        abbrevation:
        {
          abbrev: 'ct',
          text: 'Controller Test'
        }
      }
    end
    assert_redirected_to abbrevations_url
  end

  test "deleting an abbrevation" do
    log_in_as(@admin)
    assert_difference 'Abbrevation.count', -1 do
      delete :destroy, params: { id: @one.id }
    end
    assert_redirected_to abbrevations_path
  end
end
