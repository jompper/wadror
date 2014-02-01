class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  validates :beer_club, :uniqueness => {:scope => :user, :message => 'have already been joined'}

end
