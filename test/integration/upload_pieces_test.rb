require 'application_system_test_case'

class UploadPiecesTest < ApplicationSystemTestCase
  setup do
    @root_user = users(:root)
  end

  def assert_uploading_csv(filename, error_text)
    log_in_as @root_user
    visit pieces_path
    attach_file 'file', Rails.root.join('test/fixtures/files', filename), visible: false
    assert_text "The registration failed"
    assert_text error_text
  end

  test "can't upload when title is empty" do
    assert_uploading_csv 'title_empty.csv', "Line 2 : Title can't be blank"
  end

  test "can't upload when year is invalid" do
    assert_uploading_csv 'year_invalid.csv', "Line 2 : Year is integer only."
  end

  test "can't upload when url is invalid" do
    assert_uploading_csv 'url_invalid.csv', "Line 2 : Data is invalid"
  end
end
