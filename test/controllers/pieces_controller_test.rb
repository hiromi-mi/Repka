require 'test_helper'

class PiecesControllerTest < ActionDispatch::IntegrationTest
  def setup
  end

  test "should redirect pieces when not logged in" do
    get pieces_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
