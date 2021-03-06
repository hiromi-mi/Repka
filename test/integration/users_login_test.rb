require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:root)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { name:    @user.name,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to pieces_path
    follow_redirect!
    assert_template 'pieces/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to login_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
