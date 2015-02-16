require 'test_helper'

class AbbrevationsDeleteTest < ActionDispatch::IntegrationTest
  fixtures :users, :abbrevations

  def setup
    @admin = users(:admin)
    @one   = abbrevations(:one)
  end

  test "deleting an abbrevation" do
    delete abbrevation_path(@one)
    assert_redirected_to login_path
    log_in_as(@admin)
    assert_difference 'Abbrevation.count', -1 do
      delete abbrevation_path(@one)
    end
    assert_redirected_to abbrevations_path
    follow_redirect!
    assert_match 'Toni Schmidbauer', response.body, 0
  end
end
