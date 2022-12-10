require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a too short password" do
    user = User.create username: "Pekka", password: "Ab1", password_confirmation: "Ab1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password that has only small letters" do
    user = User.create username: "Pekka", password: "password", password_confirmation: "password"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({ user: user }, 20)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({ user: user }, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has a method for determining favorite style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({ user: user }, 20)

      expect(user.favorite_style).to eq(beer.style.name)
    end

    it "is the style with highest average rating if several rated" do
      create_beers_with_many_ratings({ user: user }, 10, 20, 15, 7, 9)
      style = FactoryBot.create(:style, name: 'Porter')
      best = FactoryBot.create(:beer, name: 'Guinness', style: style)
      FactoryBot.create(:rating, beer: best, score: 50, user: user)

      expect(user.favorite_style).to eq(best.style.name)
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has a method for determining favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({ user: user }, 20)

      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end

    it "is the brewery with highest average rating if several rated" do
      brewery1 = FactoryBot.create(:brewery, name: "Brewery1")
      brewery2 = FactoryBot.create(:brewery, name: "Brewery2")
      beer1 = FactoryBot.create(:beer, brewery: brewery1)
      beer2 = FactoryBot.create(:beer, brewery: brewery1)
      beer3 = FactoryBot.create(:beer, brewery: brewery2)
      beer4 = FactoryBot.create(:beer, brewery: brewery2)
      FactoryBot.create(:rating, beer: beer1, score: 5, user: user)
      FactoryBot.create(:rating, beer: beer2, score: 6, user: user)
      FactoryBot.create(:rating, beer: beer3, score: 7, user: user)
      FactoryBot.create(:rating, beer: beer4, score: 8, user: user)

      expect(user.favorite_brewery).to eq(brewery2.name)
    end
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end # describe user
