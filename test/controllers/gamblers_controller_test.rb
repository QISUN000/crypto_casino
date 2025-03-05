require "test_helper"

class GamblersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gamblers_index_url
    assert_response :success
  end

  test "should get show" do
    get gamblers_show_url
    assert_response :success
  end
end
