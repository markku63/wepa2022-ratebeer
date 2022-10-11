class BeerClub < ApplicationRecord
  has_many :members, through: :memberships, source: :user
end
