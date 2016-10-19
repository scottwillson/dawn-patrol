require "rails_helper"

RSpec.describe "Events::Create" do
  it "creates event that starts in association's time zone" do
    DawnPatrol::Association.current = DawnPatrol::Association.create!(time_zone: "Eastern Time (US & Canada)")

    event = Events::Create.new.do_it!

    expect(event.starts_at).to eq(Time.current.in_time_zone("Eastern Time (US & Canada)").beginning_of_day)
  end
end
