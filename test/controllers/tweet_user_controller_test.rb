require 'test_helper'

class TweetUserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tweet_user_index_url
    assert_response :success
  end

  test "should get show" do
    get tweet_user_show_url
    assert_response :success
  end

end
