class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { in: 3..30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/,
                                 message: "not complex enough" }

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_by(my_ratings, criteria)
    by_criteria = my_ratings
                  .group_by { |rating| rating.beer.send(criteria) }
                  .map { |key, val| [key, val.sum(&:score) / val.size] }

    by_criteria.max_by(&:last).first
  end

  def favorite_style
    return nil if ratings.empty?

    favorite_by(ratings, :style)
  end

  def favorite_brewery
    return nil if ratings.empty?

    favorite_by(ratings, :brewery)
  end

  def self.top(amount)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |u| -u.ratings.count }
    sorted_by_rating_in_desc_order[0, amount]
  end

  #  def favorite_style
  #    return nil if ratings.empty?
  #
  #    beers.find_by_sql(["SELECT styles.name, AVG(ratings.score) AS avg_score
  #      FROM styles, ratings, beers
  #      WHERE beers.id = ratings.beer_id AND beers.style_id = styles.id AND ratings.user_id = ?
  #      GROUP BY styles.name
  #      ORDER BY avg_score DESC
  #      LIMIT 1", id])[0].name
  #  end

  #  def favorite_brewery
  #    return nil if ratings.empty?
  #
  #    beers.find_by_sql(["SELECT breweries.name, AVG(ratings.score) AS avg_score
  #      FROM breweries, ratings, beers
  #      WHERE beers.id = ratings.beer_id AND beers.brewery_id = breweries.id AND ratings.user_id = ?
  #      GROUP BY breweries.name
  #      ORDER BY avg_score DESC
  #      LIMIT 1", id])[0].name
  #  end
end
