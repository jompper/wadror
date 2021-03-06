class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: {minimum: 3, maximum: 15}

  validates :password, length: {minimum: 4}, format: {with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[\d])/,
  message: 'Password must contain at least one lowercase and one uppercase character and one number'}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    Style.find(ratings.joins(:beer).group("style_id").average("score").max_by{|key, value| value}.first)
  end

  def favorite_brewery
    return nil if ratings.empty?
    Brewery.find(ratings.joins(:beer).group("brewery_id").average("score").max_by{|key, value| value}.first)
  end

  def to_s
    "#{username}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count||0) }
    sorted_by_rating_in_desc_order.first(n)
  end
end
