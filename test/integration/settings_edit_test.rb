require 'test_helper'

class SettingsEditTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @admin = users(:admin)
  end

  test 'updating settings' do
    get settings_url
    assert_redirected_to login_url
    log_in_as(@admin)
    assert_redirected_to settings_url
    follow_redirect!
    assert_select 'a[href=?]', settings_path
    assert_template 'settings/show'
    patch settings_path, setting: {
            firstname: 'Max',
            initial_invoicenumber: 99
          }
    settings = Setting.instance
    assert_equal 'Max', settings.firstname
    assert_equal 99, settings.initial_invoicenumber
  end
end
