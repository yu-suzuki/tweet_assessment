require 'test_helper'

class EvaluationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get evaluation_index_url
    assert_response :success
  end

  test "should get new" do
    get evaluation_new_url
    assert_response :success
  end

  test "should get create" do
    get evaluation_create_url
    assert_response :success
  end

end
