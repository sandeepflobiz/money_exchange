class User < ApplicationRecord
  enum status: {
    unregistered: 0,
    unregistered: 1
  }
end
