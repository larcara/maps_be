require 'test_helper'

class API::ConfigControllerTest < ActionController::TestCase
  test "should get getSections" do
    get :getSections
    assert_response :success
  end

  test "should get getFieldDetail" do
    get :getFieldDetail
    assert_response :success
  end

  test "should get getSectionFieldDetail" do
    get :getSectionFieldDetail
    assert_response :success
  end

end
