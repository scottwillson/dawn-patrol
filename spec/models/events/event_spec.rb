require 'rails_helper'

RSpec.describe Events::Event, type: :model do
  it "creates blank Event" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    event = Events::Event.create!(starts_at: 1.week.from_now)
    expect(event.name).to eq("New Event")
  end
end
