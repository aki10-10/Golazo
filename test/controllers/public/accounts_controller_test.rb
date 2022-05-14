require "test_helper"

class Public::AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get unsbscribe" do
    get public_accounts_unsbscribe_url
    assert_response :success
  end
end
