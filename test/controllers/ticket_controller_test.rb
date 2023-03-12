require "test_helper"

class TicketControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ticket_create_url
    assert_response :success
  end

  test "should get destroy" do
    get ticket_destroy_url
    assert_response :success
  end
end
