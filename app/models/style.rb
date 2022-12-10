class Style < ApplicationRecord
  has_many :beers, dependent: :nullify
  validates :name, presence: true
end
