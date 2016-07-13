require "rails_helper"

RSpec.describe "Events::FindAll" do
  it "finds all Events for current year" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    Events::Event.create!(starts_at: 1.year.ago.end_of_year)
    event = Events::Event.create!(starts_at: Time.current)
    Events::Event.create!(starts_at: 1.year.from_now.beginning_of_year)

    events = Events::FindAll.new.do_it!

    expect(events).to eq([ event ])
  end

  it "finds all Events for year" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    event = Events::Event.create!(starts_at: 1.year.ago.end_of_year)
    Events::Event.create!(starts_at: Time.current)
    Events::Event.create!(starts_at: 1.year.from_now.beginning_of_year)

    events = Events::FindAll.new(year: 1.year.ago.year).do_it!

    expect(events).to eq([ event ])
  end
end
