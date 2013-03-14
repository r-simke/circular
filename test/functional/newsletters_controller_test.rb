require 'test_helper'

class NewslettersControllerTest < ActionController::TestCase
  setup do
    @newsletter = newsletters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsletters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsletter" do
    assert_difference('Newsletter.count') do
      post :create, newsletter: { author_id: @newsletter.author_id, code: @newsletter.code, content: @newsletter.content, show_dividerline: @newsletter.show_dividerline, show_outline: @newsletter.show_outline, status_id: @newsletter.status_id, template_id: @newsletter.template_id, topic: @newsletter.topic }
    end

    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  test "should show newsletter" do
    get :show, id: @newsletter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newsletter
    assert_response :success
  end

  test "should update newsletter" do
    put :update, id: @newsletter, newsletter: { author_id: @newsletter.author_id, code: @newsletter.code, content: @newsletter.content, show_dividerline: @newsletter.show_dividerline, show_outline: @newsletter.show_outline, status_id: @newsletter.status_id, template_id: @newsletter.template_id, topic: @newsletter.topic }
    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  test "should destroy newsletter" do
    assert_difference('Newsletter.count', -1) do
      delete :destroy, id: @newsletter
    end

    assert_redirected_to newsletters_path
  end
end
