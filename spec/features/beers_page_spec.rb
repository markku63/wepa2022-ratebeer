require 'rails_helper'

include Helpers

describe "Beers page" do
  before :each do
    FactoryBot.create :user
    FactoryBot.create :brewery, name: "Schlenkerla", year: 1678
    FactoryBot.create :style, name: "IPA"
    sign_in(username: "Pekka", password: "Foobar1")
  end

  describe "when signed in" do
    it "should allow creating with valid name" do
      visit new_beer_path
      fill_in('beer[name]', with: 'Beer1')
      select('IPA', from: 'beer[style_id]')
      select('Schlenkerla', from: 'beer[brewery_id]')
      expect{
        click_button('Create Beer')
      }.to change{ Beer.count }.by(1)
      expect(page).to have_content 'Beer was successfully created'
      expect(page).to have_content 'Beer1'
    end

    it "should prevent creating with invalid name" do
      visit new_beer_path
      click_button('Create Beer')

      expect(page).to have_content 'error prohibited this beer from being saved'
      expect(page).to have_content "Name can't be blank"
    end
  end
end
