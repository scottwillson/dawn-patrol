require "rails_helper"

RSpec.describe "RacingOnRails::ImportDatabase" do
  it "imports Racing on Rails data" do
    expect(DawnPatrol::Association.count).to eq(0)

    RacingOnRails::ImportDatabase.new(association: "atra").do_it!
    RacingOnRails::ImportDatabase.new(association: "wsba").do_it!

    ActsAsTenant.with_tenant(DawnPatrol::Association.where(key: "atra").first!) do
      expect(Events::Event.count).to eq(1)
      event = Events::Event.first
      expect(event.name).to eq("Hellyer Challenge")
      expect(event.city).to eq("San Jose")
      expect(event.starts_at).to eq(Time.zone.local(2009, 7, 3))
      expect(event.discipline).to eq("Track")
      expect(event.state).to eq("CA")
    end

    ActsAsTenant.with_tenant(DawnPatrol::Association.where(key: "wsba").first!) do
      expect(Events::Event.count).to eq(1)
      event = Events::Event.first
      expect(event.name).to eq("Tahuya-Seabeck-Tahuya Road Race")
      expect(event.city).to eq("Tahuya")
      expect(event.starts_at).to eq(Time.zone.local(2004, 5, 10))
      expect(event.discipline).to eq("Road")
      expect(event.state).to eq("WA")
    end
  end
end
