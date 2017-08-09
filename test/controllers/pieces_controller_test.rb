require 'test_helper'

class PiecesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @root_user = users(:root)
    @shiketai_user = users(:shiketai)
    @normal_user = users(:normal)
  end

  test "should redirect pieces when not logged in" do
    get pieces_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "root should get all info in pieces" do
    log_in_as(@root_user)
    get pieces_path
    assert_select 'div#management'
    assert_select 'div#pieces > table > thead > th', count: 7
  end

  test "shiketai should get limited info in pieces" do
    log_in_as(@root_user)
    get pieces_path
    assert_select 'div#management'
    assert_select 'div#pieces > table > thead > th', count: 7
  end

  test "normal user should get limited info in pieces" do
    log_in_as(@root_user)
    get pieces_path
    assert_select 'div#management', count: 0
    assert_select 'div#pieces > table > thead > th', count: 6
  end
end
