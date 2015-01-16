require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  include PatientsHelper

  self.use_transactional_fixtures = true

  test "show welcome if there are no patients" do
    get :index
    if not have_patients?
      assert_template 'welcome'
    else
      assert_template 'index'
    end
  end

end
