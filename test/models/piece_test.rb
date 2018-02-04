require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:root)
    @piece = @user.pieces.build(title: 'Title', teacher: 'Teacher', year: 2010, kind: 'report', data: 'http://www.google.com/')
  end

  test 'should be valid' do
    assert @piece.valid?
  end

  test 'user id should be present' do
    @piece.user_id = nil
    assert_not @piece.valid?
  end
end
