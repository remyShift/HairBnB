require "test_helper"

class WigsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wigs_index_url
    assert_response :success
  end
end
