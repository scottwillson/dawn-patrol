require 'spec_helper'

RSpec.describe "DawnPatrol", type: "feature" do
  it "shows a webpage" do
    visit "http://localhost:8080/"
    expect(page).to have_css "h2", text: "Dawn Patrol"
    expect(page).to have_css ".events", text: "4 events"
  end
end
