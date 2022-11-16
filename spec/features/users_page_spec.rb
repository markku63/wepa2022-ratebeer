require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')

      expect{
        click_button('Create User')
      }.to change{ User.count }.by(1)
    end

    it "can sign out" do
      sign_in(username: "Pekka", password: "Foobar1")
      click_link('Sign out')

      expect(page).to have_content('Sign in')
    end
  end

  describe "page" do
    let!(:user2) { FactoryBot.create :user, username: 'Brian', password: 'Secret55', password_confirmation: 'Secret55' }
    let!(:brewery1) { FactoryBot.create :brewery, name: "Koff" }
    let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery: brewery1 }
    let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery: brewery1 }
    let!(:rating1) { FactoryBot.create :rating, user: @user, beer: beer1, score: 10 }
    let!(:rating2) { FactoryBot.create :rating, user: user2, beer: beer2, score: 20 }
    let!(:rating3) { FactoryBot.create :rating, user: user2, beer: beer1, score: 30 }

    it "shows only ratings for selected user" do
      visit user_path(@user)
      expect(page).to have_content @user.username
      expect(page).to have_content 'Has made 1 rating'

      visit user_path(user2)
      expect(page).to have_content user2.username
      expect(page).to have_content 'Has made 2 ratings'
    end

    it "allows signed in user to delete ratings" do
      sign_in(username: 'Brian', password: 'Secret55')

      expect{
        page.find('li', text: 'iso 3').click_link('Delete')
      }.to change{ Rating.count }.by(-1)
    end

    it "shows user's favorite beer style" do
      visit user_path(@user)

      expect(page).to have_content 'Favorite style: Lager'
    end

    it "shows user's favorite brewery" do
      visit user_path(@user)

      expect(page).to have_content 'Favorite brewery: Koff'
    end
  end
end
