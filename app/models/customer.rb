class Customer < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true,
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\d+/ }
end
