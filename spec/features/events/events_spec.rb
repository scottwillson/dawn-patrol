require "rails_helper"

RSpec.describe "event results", type: :feature do
  it "lists events" do
    save_default_current_association!
    Events::Create.new(name: "Copperopolis Road Race").do_it!
    visit "/events/events"
    expect(page).to have_css ".events a", text: "Copperopolis Road Race"
  end
end
