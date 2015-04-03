require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  fixtures :users, :patients

  def setup
    @admin  = users(:admin)
    @max    = patients(:max)
    @moritz = patients(:moritz)
  end

  test 'should redirect create when not logged in' do
    post :create, patient_id: @max
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'should redirect new when not logged in' do
    get :new, patient_id: @max
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'create a new invoice for max works' do
    log_in_as(@admin)
    get :new, patient_id: @max
    assert_response :success
  end

  test 'create a new invoice for moritz works' do
    log_in_as(@admin)
    get :new, patient_id: @moritz
    assert_response :success
    assert_not_nil assigns(:patient)
    assert_not_nil assigns(:invoice)
    assert_not_nil assigns(:settings)
    assert_not_nil assigns(:invoicenumber)
  end

  test 'invoicenumber is correct' do
    setting = Setting.instance
    setting.initial_invoicenumber = 99
    setting.save

    log_in_as(@admin)
    get :new, patient_id: @max
    assert_match(/99/, assigns(:invoicenumber))
  end

  test 'saving an invoice' do
    log_in_as(@admin)
    assert_difference'Invoice.count', 1 do
      post :create, patient_id: @max, invoice: {
             diagnosis: 'test',
             invoicenumber: '1-1-1-1970',
             date: '1-1-1970',
           }
    end

    assert_redirected_to patients_url
  end
end
