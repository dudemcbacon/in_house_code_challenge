require 'test_helper'
require 'pry'

class ApplicationControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should not show import form when not logged in" do
    sign_out :user
    get :index
    assert_select 'form#upload_form', false
  end

  test "should show import form when logged in" do
    get :index
    assert_select 'form#upload_form'
  end

  test "should show login link when not logged in" do
    sign_out :user
    get :index
    assert_select '#user_dropdown', test: 'Login'
  end

  test "should show username when logged in" do
    get :index
    assert_select '#user_dropdown', test: 'test@drdealaday.org'
  end

  test "should show alert when uploading duplicate file" do
    post :upload, file: fixture_file_upload('files/example_data.csv', 'text/csv')
    assert_redirected_to '/'
    assert_equal('Duplicate file import detected', flash[:alert])
  end

  test "should show alert when uploading unsupported file" do
    post :upload, file: fixture_file_upload('files/data.csv', 'text/unsupported')
    assert_redirected_to '/'
    assert_equal('Unsupported file type', flash[:alert])
  end

  test "should show notice when uploading valid csv file" do
    post :upload, file: fixture_file_upload('files/data.csv', 'text/csv')
    assert_redirected_to '/'
    assert_equal('Added 1 order(s) totaling $20.00 dollars. Total revenue is now $24.50', flash[:notice])
  end

  test "should show notice when uploading valid tsv file" do
    post :upload, file: fixture_file_upload('files/data.tsv', 'text/tab-separated-values')
    assert_redirected_to '/'
    assert_equal('Added 1 order(s) totaling $20.00 dollars. Total revenue is now $24.50', flash[:notice])
  end

  test "should show new orders when csv datafile is uploaded" do
    get :index
    assert_difference 'Order.count' do
      post :upload, file: fixture_file_upload('files/data.csv', 'text/csv')
    end
  end

  test "should show new orders when tsv datafile is uploaded" do
    get :index
    assert_difference 'Order.count' do
      post :upload, file: fixture_file_upload('files/data.tsv', 'text/tab-separated-values')
    end
  end
end
