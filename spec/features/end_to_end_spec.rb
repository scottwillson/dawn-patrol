require "rails_helper"


RSpec.describe "DawnPatrol", type: :feature do
  it "imports Racing on Rails data and displays it on a webpage" do
    travel_to 1.day.ago do
      RacingOnRails::ImportDatabase.new(association: "ATRA").do_it!
    end

    RacingOnRails::ImportDatabase.new(association: "WSBA").do_it!

    visit "/events/events"
    expect(page).to have_no_css ".events a", text: "Hellyer Challenge"
    expect(page).to have_no_css ".events a", text: "Tahuya-Seabeck-Tahuya Road Race"

    visit "/events/events?year=2009"
    expect(page).to have_css ".events a", text: "Hellyer Challenge"
    expect(page).to have_no_css ".events a", text: "Tahuya-Seabeck-Tahuya Road Race"
  end
end
