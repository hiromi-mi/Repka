class Piece < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :teacher, length: { maximum: 255 }
  validates :kind, length: { maximum: 255 }
  validates :data, format: /\A#{URI::regexp(%w(http https))}\z/
end
