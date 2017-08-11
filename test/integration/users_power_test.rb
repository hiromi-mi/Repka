require 'test_helper'

class UsersPowerTest < ActionDispatch::IntegrationTest
  def setup
    @root_user = users(:root)
    @shiketai_user = users(:shiketai)
    @normal_user = users(:normal)
    @piece = pieces(:one)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Piece.count' do
      delete piece_path(@piece)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a normal" do
    log_in_as(@normal_user)
    assert_no_difference 'User.count' do
      delete piece_path(@piece)
    end
    assert_redirected_to pieces_url
  end
end


require 'application_system_test_case'

class UploadPiecesTest < ApplicationSystemTestCase
  setup do
  end

  def assert_correctly_powered(user, config)
    log_in_as user
    visit pieces_path
    assert_selector 'div#management', count: config[:management_div] ? 1 : 0
    assert_selector 'label.btn', text: 'Upload Pieces data', count: config[:upload_pieces_data_button] ? 1 : 0
    assert_selector 'a.btn', text: 'Download template CSV', count: config[:upload_pieces_data_button] ? 1 : 0
    assert_selector 'a.btn.btn-danger', text: 'Delete', exist: config[:delete_button]
  end

  test "root should get all info in pieces" do
    assert_correctly_powered users(:root),
      management_div: true, upload_pieces_data_button: true, delete_button: true
  end

  test "shiketai should get limited info in pieces" do
    assert_correctly_powered users(:shiketai),
      management_div: true, upload_pieces_data_button: true, delete_button: true
  end

  test "normal user should get limited info in pieces" do
    assert_correctly_powered users(:normal),
      management_div: false, upload_pieces_data_button: false, delete_button: false
  end
end
