require "rails_helper"

RSpec.describe "Events::FindAll" do
  it "finds all Events for current year" do
    DawnPatrol::Association.current = DawnPatrol::Association.create!
    Events::Create.new(starts_at: 1.year.ago.end_of_year).do_it!
    event = Events::Create.new(starts_at: Time.current).do_it!
    Events::Create.new(starts_at: 1.year.from_now.beginning_of_year).do_it!

    events = Events::FindAll.new.do_it!

    expect(events).to eq([ event ])
  end

  it "finds all Events for year" do
    DawnPatrol::Association.current = DawnPatrol::Association.create!
    event = Events::Create.new(starts_at: 1.year.ago.end_of_year).do_it!
    Events::Create.new(starts_at: Time.current).do_it!
    Events::Create.new(starts_at: 1.year.from_now.beginning_of_year).do_it!

    events = Events::FindAll.new(year: 1.year.ago.year).do_it!

    expect(events).to eq([ event ])
  end
end
