require "test_helper"

class CasinoTablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get casino_tables_index_url
    assert_response :success
  end

  test "should get show" do
    get casino_tables_show_url
    assert_response :success
  end
end
