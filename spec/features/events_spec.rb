require "rails_helper"

RSpec.describe "event results", type: :feature do
  it "lists events" do
    save_default_current_association!
    Events::Create.new(name: "Copperopolis Road Race").do_it!
    visit "/events"
    expect(page).to have_no_css ".alert"
    expect(page).to have_text("Copperopolis Road Race")
    expect(page).to have_css "a", text: "Copperopolis Road Race"
  end
end
