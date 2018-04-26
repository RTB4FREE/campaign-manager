require 'test_helper'

class BannersControllerTest < ActionController::TestCase
  setup do
    @banner = banners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banner" do
    assert_difference('Banner.count') do
      post :create, banner: {  }
    end

    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should show banner" do
    get :show, id: @banner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banner
    assert_response :success
  end

  test "should update banner" do
    patch :update, id: @banner, banner: {  }
    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should destroy banner" do
    assert_difference('Banner.count', -1) do
      delete :destroy, id: @banner
    end

    assert_redirected_to banners_path
  end
end
