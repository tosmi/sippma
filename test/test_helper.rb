ENV['RAILS_ENV'] ||= 'test'
require 'coveralls'
Coveralls.wear!('rails')

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, options = {})
    password = options[:password]  || 'changeme'
    if integration_test?
      post login_path, params: { session: { username: user.username, password: password } }
    else
      session[:user_id] = user.id
    end
  end

  private

  def integration_test?
    defined?(post_via_redirect)
  end
end
