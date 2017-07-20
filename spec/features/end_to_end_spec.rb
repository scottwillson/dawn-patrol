require "rails_helper"

RSpec.describe "DawnPatrol" do
  it "imports Racing on Rails data and displays it on a webpage" do
    travel_to 1.day.ago do
      RacingOnRails::ImportDatabase.new(association: "ATRA").do_it!
    end

    RacingOnRails::ImportDatabase.new(association: "WSBA").do_it!

    visit "/events"
    expect(page).to have_css ".container"
    expect(page).to have_css "table"
    expect(page).to have_css ".events"
    expect(page).to have_no_css ".events a", text: "Hellyer Challenge"
    expect(page).to have_no_css ".events a", text: "Tahuya-Seabeck-Tahuya Road Race"

    select("2009", from: "year")
    expect(page).to have_css ".events"
    expect(page).to have_css ".events a", text: "Hellyer Challenge"
    expect(page).to have_no_css ".events a", text: "Tahuya-Seabeck-Tahuya Road Race"

    click_on "Hellyer Challenge"
    expect(page).to have_text "Jame Carney"
  end
end
