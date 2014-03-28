require 'test_helper'

class API::MuseumControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

  test "should get getMuseumData" do
    get :getMuseumData
    assert_response :success
  end

  test "should get getSections" do
    get :getSections
    assert_response :success
  end

  test "should get getSectionDetail" do
    get :getSectionDetail
    assert_response :success
  end

end
