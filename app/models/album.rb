class Album < ApplicationRecord
  belongs_to :artist
  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
end
