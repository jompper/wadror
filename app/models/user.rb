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

  def to_s
    "#{username}"
  end
end
