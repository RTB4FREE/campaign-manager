require 'test_helper'

class BannerVideosControllerTest < ActionController::TestCase
  setup do
    @banner_video = banner_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banner_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banner_video" do
    assert_difference('BannerVideo.count') do
      post :create, banner_video: {  }
    end

    assert_redirected_to banner_video_path(assigns(:banner_video))
  end

  test "should show banner_video" do
    get :show, id: @banner_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banner_video
    assert_response :success
  end

  test "should update banner_video" do
    patch :update, id: @banner_video, banner_video: {  }
    assert_redirected_to banner_video_path(assigns(:banner_video))
  end

  test "should destroy banner_video" do
    assert_difference('BannerVideo.count', -1) do
      delete :destroy, id: @banner_video
    end

    assert_redirected_to banner_videos_path
  end
end
