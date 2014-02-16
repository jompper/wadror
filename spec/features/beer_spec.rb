require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is saved with correct values" do
    visit new_beer_path
    fill_in('beer_name', with:'Iso 3')
    select('Lager', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)


    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Iso 3"


  end

  it "is not saved with missing values" do
    visit new_beer_path
    select('Lager', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')



    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
  end
end