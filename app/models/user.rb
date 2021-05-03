class User < ApplicationRecord
  validates :name, presence: true
  # VALID_MOBILE_REGEX = '((\+*)((0[ -]+)*|(91 )*)(\d{12}+|\d{10}+))|\d{5}([- ]*)\d{6}'
  validates :mobile, presence: true, length: {minimum: 10,maximum: 10}, uniqueness: true
  validates :password, presence: true, length: {minimum:8 , maximum: 16}
  has_secure_password
end
