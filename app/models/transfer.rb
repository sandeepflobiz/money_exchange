class Transfer < ApplicationRecord
  belongs_to :user
  enum currency: {
    rupee: 0,
    dollar: 1,
    pound: 2,
    yen: 3,
    taka: 4
  }
end
