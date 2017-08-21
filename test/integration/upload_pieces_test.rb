require 'application_system_test_case'

class UploadPiecesTest < ApplicationSystemTestCase
  setup do
    @root_user = users(:root)
  end

  def visit_pieces
    log_in_as @root_user
    visit pieces_path
  end

  def upload_pieces_data(filename)
    attach_file 'file', Rails.root.join('test/fixtures/files', filename), visible: false
  end

  def assert_success
    assert_text 'The registration succeeded.'
  end

  def assert_failure(reason)
    assert_text 'The registration failed'
    assert_text reason
  end

  test "can't upload when title is empty" do
    visit_pieces
    upload_pieces_data 'title_empty.csv'
    assert_failure "Line 2 : Title can't be blank"
  end

  test "can't upload when year is invalid" do
    visit_pieces
    upload_pieces_data 'year_invalid.csv'
    assert_failure "Line 2 : Year is integer only."
  end

  test "can't upload when url is invalid" do
    visit_pieces
    upload_pieces_data 'url_invalid.csv'
    assert_failure "Line 2 : Data is invalid"
  end

  test "can upload csv" do
    visit_pieces
    upload_pieces_data 'correct.csv'
    assert_success
  end

  test "can't upload when file with utf8 bom" do
    visit_pieces
    upload_pieces_data 'utf8_bom.csv'
    assert_failure "Line 2 : CSV file should be UTF-8 without BOM (i.e. UTF-8N)"
  end

  test "can upload ods" do
    visit_pieces
    upload_pieces_data 'correct.ods'
    assert_success
  end

  test "can upload xls" do
    visit_pieces
    upload_pieces_data 'correct.xls'
    assert_success
  end

  test "can upload xlsx" do
    visit_pieces
    upload_pieces_data 'correct.xlsx'
    assert_success
  end
end
