require 'test_helper'

class Public::OrderDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_order_details_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_order_details_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_order_details_update_url
    assert_response :success
  end

end
