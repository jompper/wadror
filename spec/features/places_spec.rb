require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:id => 1, :name => "Oljenkorsi") ]
    )



    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple is returned by the API, all are show at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:id => 1, :name => "Oljenkorsi"), Place.new(:id => 1, :name => "Tempputeemu"), Place.new(:id => 1, :name => "Vuoristorata") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Tempputeemu"
    expect(page).to have_content "Vuoristorata"
  end

  it "if none is returned by the API, shows suitable notice" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end