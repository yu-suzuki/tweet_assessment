require 'test_helper'

class TaskQueuesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get task_queues_index_url
    assert_response :success
  end

end
