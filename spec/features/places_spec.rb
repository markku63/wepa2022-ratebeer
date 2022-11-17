require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name: "Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned, all are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("tampere").and_return(
      [Place.new(name: "Salhojankadun Pub", id: 1),
       Place.new(name: "Plevna", id: 2)]
    )

    visit places_path
    fill_in('city', with: 'tampere')
    click_button "Search"

    expect(page).to have_content "Plevna"
    expect(page).to have_content "Salhojankadun Pub"
  end

  it "if none are returned, a notice is shown" do
    visit places_path
  end
end
