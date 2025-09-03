require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get incoming_requests" do
    get transactions_incoming_requests_url
    assert_response :success
  end

  test "should get my_requests" do
    get transactions_my_requests_url
    assert_response :success
  end

  test "should get show" do
    get transactions_show_url
    assert_response :success
  end

  test "should get create" do
    get transactions_create_url
    assert_response :success
  end

  test "should get accept" do
    get transactions_accept_url
    assert_response :success
  end
end
