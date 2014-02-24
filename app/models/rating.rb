class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
  validates :beer_id, uniqueness: {scope: :user_id, message: 'has already been rated'}

  scope :recent, -> {last(5)}

  def to_s
    "#{beer.name} (#{score} - #{user.username})"
  end

end
