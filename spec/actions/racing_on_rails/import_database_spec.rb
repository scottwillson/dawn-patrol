require "rails_helper"

RSpec.describe "RacingOnRails::ImportDatabase" do
  it "imports Racing on Rails data" do
    expect(Events::Event.count).to eq(0)
    RacingOnRails::ImportDatabase.new.do_it!
    expect(Events::Event.count).to eq(1)

    event = Events::Event.first
    expect(event.name).to eq("Banana Belt Road Race")
    expect(event.city).to eq("Forest Grove")
    expect(event.starts_at).to eq(Time.zone.local(2004, 2, 26, 0, 0, 0))
    expect(event.discipline).to eq("Road")
    expect(event.state).to eq("OR")
  end
end
