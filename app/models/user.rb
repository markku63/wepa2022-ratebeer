class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { in: 3..30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/,
                                 message: "not complex enough" }

  has_many :ratings
  has_many :beers, through: :ratings
end
