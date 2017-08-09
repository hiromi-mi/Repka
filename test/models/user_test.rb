require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", power: 5,
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
    @user.name = nil
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "name should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "power should be present" do
    @user.power = nil
    assert_not @user.valid?
  end

  test "power should be integer" do
    @user.power = 'AAA'
    assert_not @user.valid?
  end

  test "power should be >= 0" do
    @user.power = -1
    assert_not @user.valid?
  end

  test 'power should be <= 5' do
    @user.power = 6
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
