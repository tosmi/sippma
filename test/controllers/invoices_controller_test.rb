require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  fixtures :users, :patients, :invoices

  def setup
    @admin  = users(:admin)
    @max    = patients(:max)
    @moritz = patients(:moritz)
    @one    = invoices(:one)
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
  end

  test 'invoicenumber is correct' do
    setting = Setting.instance
    setting.initial_invoicenumber = 99
    setting.save

    log_in_as(@admin)
    get :new, patient_id: @max
    assert_match(/99/, assigns(:invoice).invoicenumber)
  end

  test 'saving an invoice' do
    log_in_as(@admin)
    setting = Setting.instance
    assert_difference 'setting.current_invoicenumber', 1 do
      assert_difference'Invoice.count', 1 do
        post :create, patient_id: @max, invoice: {
               diagnosis: 'test',
               invoicenumber: '01-01-01-70',
               date: '1-1-1970',
               totalfee: 100,
             }
      end
      setting.reload
    end
    assert_redirected_to patients_url
  end

  test 'displaying an invoice' do
    log_in_as(@admin)
    get :show, id: @one
    assert_response :success
  end

  test 'editing an invoice' do
    log_in_as(@admin)
    get :edit, id: @one
    assert_response :success
    post :update, id: @one, invoice: {
           diagnosis: 'sick'
         }
  end

  test 'listing invoices' do
    log_in_as(@admin)
    get :index, patient_id: @max
    assert_response :success
  end
end
