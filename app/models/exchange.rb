class Exchange < ApplicationRecord
  belongs_to :user
  enum currency: [ :rupee, :dollar, :pound,:yen ,:taka ], _prefix: :primary
  enum currency: [ :rupee, :dollar, :pound,:yen ,:taka ], _prefix: :secondary
end
