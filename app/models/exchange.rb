class Exchange < ApplicationRecord
  belongs_to :user
  enum primary_currency: {
    rupee: 0,
    dollar: 1,
    pound: 2,
    yen: 3,
    taka: 4
  }
  enum secondary_currency: {
    rupee: 0,
    dollar: 1,
    pound: 2,
    yen: 3,
    taka: 4
  }
end
