require_relative 'artist'

class Order < ApplicationRecord
  validates :date, presence: true, date_not_future: true
  validates :total, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :customer
end
