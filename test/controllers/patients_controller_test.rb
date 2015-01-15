require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  include PatientsHelper

  self.use_transactional_fixtures = true

  test "show welcome if there are no patients" do
    get :index
    if not have_patients?
      assert_redirected_to 'no_patients'
    else
      assert_redirected_to 'new'
    end
  end

end
