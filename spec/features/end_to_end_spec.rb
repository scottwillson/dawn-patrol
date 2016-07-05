require 'rails_helper'

RSpec.describe "DawnPatrol", type: :feature do
  it "imports Racing on Rails data and displays it on a webpage" do
    RacingOnRails::ImportDatabase.new.do_it!
    visit "/events/events"
    expect(page).to have_css ".events a", text: "Banana Belt Road Race"
  end
end
