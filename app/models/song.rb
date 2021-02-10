class Song < ApplicationRecord
  validates :name, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :album
end
