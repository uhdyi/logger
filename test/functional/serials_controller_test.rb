require 'test_helper'

class SerialsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:serials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create serial" do
    assert_difference('Serial.count') do
      post :create, :serial => { }
    end

    assert_redirected_to serial_path(assigns(:serial))
  end

  test "should show serial" do
    get :show, :id => serials(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => serials(:one).to_param
    assert_response :success
  end

  test "should update serial" do
    put :update, :id => serials(:one).to_param, :serial => { }
    assert_redirected_to serial_path(assigns(:serial))
  end

  test "should destroy serial" do
    assert_difference('Serial.count', -1) do
      delete :destroy, :id => serials(:one).to_param
    end

    assert_redirected_to serials_path
  end
end
