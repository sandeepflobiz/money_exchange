class User < ApplicationRecord
  validates :name, presence: true
  validates :mobile, presence: true, length: {minimum: 10,maximum: 10}, uniqueness: true
  enum status: {
    unregistered: 0,
    registered: 1
  }
end
