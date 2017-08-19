require 'spec_helper'

RSpec.describe "DawnPatrol", type: "feature" do
  it "shows a webpage" do
    visit "http://web/"
    expect(page).to have_css "h2", text: "Dawn Patrol"
    expect(page).to have_css ".events", text: "0 events"

    `bin/import`

    visit "http://web/"
    expect(page).to have_css ".events", text: "4 events"
  end
end
