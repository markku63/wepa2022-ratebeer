require "active_support/concern"

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.average(:score)
  end
end
