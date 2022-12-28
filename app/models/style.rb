class Style < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :nullify
  validates :name, presence: true

  def self.top(amount)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order[0, amount]
  end
end
