class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 1040 }
  validate :not_in_future

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def not_in_future
    return unless year.present? && year > Time.now.year

    errors.add(:year, "can't be in the future")
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end
