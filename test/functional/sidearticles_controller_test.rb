require 'test_helper'

class SidearticlesControllerTest < ActionController::TestCase
  setup do
    @sidearticle = sidearticles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sidearticles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sidearticle" do
    assert_difference('Sidearticle.count') do
      post :create, sidearticle: { content: @sidearticle.content, position: @sidearticle.position, topic: @sidearticle.topic }
    end

    assert_redirected_to sidearticle_path(assigns(:sidearticle))
  end

  test "should show sidearticle" do
    get :show, id: @sidearticle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sidearticle
    assert_response :success
  end

  test "should update sidearticle" do
    put :update, id: @sidearticle, sidearticle: { content: @sidearticle.content, position: @sidearticle.position, topic: @sidearticle.topic }
    assert_redirected_to sidearticle_path(assigns(:sidearticle))
  end

  test "should destroy sidearticle" do
    assert_difference('Sidearticle.count', -1) do
      delete :destroy, id: @sidearticle
    end

    assert_redirected_to sidearticles_path
  end
end
