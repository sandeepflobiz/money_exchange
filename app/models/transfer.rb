class Transfer < ApplicationRecord
  belongs_to :user
  enum primary_currency: {
    rupee: 0,
    dollar: 1,
    pound: 2,
    yen: 3,
    taka: 4
  }
  enum secondary_currency: {
    rupee_recieved: 0,
    dollar_recieved: 1,
    pound_recieved: 2,
    yen_recieved: 3,
    taka_recieved: 4
  }
end
