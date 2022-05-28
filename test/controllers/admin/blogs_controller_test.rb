require "test_helper"

class Admin::BlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_blogs_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_blogs_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_blogs_edit_url
    assert_response :success
  end
end
