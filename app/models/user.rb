class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { in: 3..30 }

  has_many :ratings
  has_many :beers, through: :ratings
end
