class Account < ApplicationRecord
  belongs_to :user
  scope :valid_account, ->(user_id,account_number) { where("user_id = ? AND account_number = ?",user_id,account_number) }
end
