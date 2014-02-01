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

  def to_s
    "#{username}"
  end
end
