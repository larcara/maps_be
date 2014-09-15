require 'test_helper'

class API::LivingMuseumControllerTest < ActionController::TestCase
  test "should get createUser" do
    get :createUser
    assert_response :success
  end

  test "should get confirmUser" do
    get :confirmUser
    assert_response :success
  end

  test "should get deleteUser" do
    get :deleteUser
    assert_response :success
  end

  test "should get destroyUser" do
    get :destroyUser
    assert_response :success
  end

  test "should get searchCard" do
    get :searchCard
    assert_response :success
  end

  test "should get saveSearch" do
    get :saveSearch
    assert_response :success
  end

  test "should get getSearch" do
    get :getSearch
    assert_response :success
  end

  test "should get listSearch" do
    get :listSearch
    assert_response :success
  end

  test "should get deleteSearch" do
    get :deleteSearch
    assert_response :success
  end

  test "should get exportCard" do
    get :exportCard
    assert_response :success
  end

end
