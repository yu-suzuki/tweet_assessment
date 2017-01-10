require 'test_helper'

class RedCardControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get red_card_new_url
    assert_response :success
  end

  test "should get create" do
    get red_card_create_url
    assert_response :success
  end

end
