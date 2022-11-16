require 'rails_helper'

include Helpers

describe "Beers page" do
  before :each do
    FactoryBot.create :user
    FactoryBot.create :brewery
  end

  it "should allow creating with valid name" do
    visit beers_path
    click_link "New beer"
    fill_in('beer_name', with: 'Beer1')
    click_button('Create Beer')

    expect(page).to have_content 'Beer was successfully created'
    expect(page).to have_content 'Beer1'
  end

  it "should prevent creating with invalid name" do
    visit beers_path
    click_link "New beer"
    click_button('Create Beer')

    expect(page).to have_content 'error prohibited this beer from being saved'
    expect(page).to have_content "Name can't be blank"
  end
end
