require 'test_helper'

class BookTopicsControllerTest < ActionController::TestCase
  setup do
    @book_topic = book_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_topic" do
    assert_difference('BookTopic.count') do
      post :create, book_topic: { book_id: @book_topic.book_id, topic_id: @book_topic.topic_id }
    end

    assert_redirected_to book_topic_path(assigns(:book_topic))
  end

  test "should show book_topic" do
    get :show, id: @book_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_topic
    assert_response :success
  end

  test "should update book_topic" do
    patch :update, id: @book_topic, book_topic: { book_id: @book_topic.book_id, topic_id: @book_topic.topic_id }
    assert_redirected_to book_topic_path(assigns(:book_topic))
  end

  test "should destroy book_topic" do
    assert_difference('BookTopic.count', -1) do
      delete :destroy, id: @book_topic
    end

    assert_redirected_to book_topics_path
  end
end
