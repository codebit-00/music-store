class AlbumOrder < ApplicationRecord
  validates :total_copies, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :album
  belongs_to :order
end
