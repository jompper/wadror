require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with not complex password" do
    user = User.create username:"Pekka", password:"passumake", password_confirmation:"passumake"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"Aa1", password_confirmation:"Aa1"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end


  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2, beer_id:1)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end


    it "is the one with highest rating if several rated" do
      l = FactoryGirl.create(:style)
      create_beers_with_ratings(10, 20, 15, 7, 9, user, l)
      best = create_beer_with_rating(25, user, l)

      expect(user.favorite_beer).to eq(best)
    end

  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style).to eq(beer.style)
    end


    it "is the one with highest rating average if several rated" do
      l = FactoryGirl.create(:style)
      nl = FactoryGirl.create(:style, name:"Not lager")

      create_beers_with_ratings(10, 20, 15, 7, 9, user, l)

      beer2 = FactoryGirl.create(:beer, style:nl)
      FactoryGirl.create(:rating, score:8, beer:beer2, user:user)

      expect(user.favorite_style.name).to eq("Lager")
    end

  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do

      brewery = FactoryGirl.create(:brewery)
      beer = FactoryGirl.create(:beer, brewery:brewery)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_brewery).to eq(brewery)
    end


    it "is the one with highest rating average if several rated" do
      brewery = FactoryGirl.create(:brewery)
      brewery2 = FactoryGirl.create(:brewery, name:"Not anonymous")
      beer = FactoryGirl.create(:beer, brewery: brewery)
      beer2 = FactoryGirl.create(:beer, brewery: brewery)
      beer3 = FactoryGirl.create(:beer, brewery: brewery)
      beer4 = FactoryGirl.create(:beer, brewery: brewery2)
      FactoryGirl.create(:rating, score:10, beer:beer, user:user)
      FactoryGirl.create(:rating, score:10, beer:beer2, user:user)
      FactoryGirl.create(:rating, score:10, beer:beer3, user:user)
      FactoryGirl.create(:rating, score:9, beer:beer4, user:user)

      expect(user.favorite_brewery).to eq(brewery)
    end

  end





end

def create_beers_with_ratings(*scores, user, style)
  scores.each do |score|
    create_beer_with_rating score, user, style
  end
end

def create_beer_with_rating(score,  user, style)
  beer = FactoryGirl.create(:beer, style:style)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end