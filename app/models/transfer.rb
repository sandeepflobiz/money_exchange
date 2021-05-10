class Transfer < ApplicationRecord
  belongs_to :user
  enum currency: [ :rupee, :dollar, :pound,:yen ,:taka ], _prefix: :primary
  enum currency: [ :rupee, :dollar, :pound,:yen ,:taka ], _prefix: :secondary
  # enum primary_currency: {
  #   rupee: 0,
  #   dollar: 1,
  #   pound: 2,
  #   yen: 3,
  #   taka: 4
  # }
  # enum secondary_currency: {
  #   rupee: 0,
  #   dollar: 1,
  #   pound: 2,
  #   yen: 3,
  #   taka: 4
  # }
end
#use suffix and prefix (redo)
