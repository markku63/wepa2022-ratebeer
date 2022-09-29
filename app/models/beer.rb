class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.map { |r| r.score }.sum / ratings.count.to_f
  end
end
