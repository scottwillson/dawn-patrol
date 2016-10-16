require "rails_helper"

RSpec.describe Events::Event, type: :model do
  it "creates blank Event" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    event = Events::Event.create!
    expect(event.name).to eq("New Event")
    expect(event.starts_at).to eq(Time.current.beginning_of_day)
  end

  it "has many promoters" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    promoter = Events::Promoter.new(person: Person.create!)
    promoter_2 = Events::Promoter.new(person: Person.create!)
    event = Events::Event.create!(promoters: [ promoter, promoter_2 ])
    expect(event.reload.promoters.map(&:person)).to contain_exactly(promoter.person, promoter_2.person)
  end

  describe "#promoter=" do
    it "adds promoter" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      promoter = Events::Promoter.new(person: Person.create!)
      event = Events::Event.create!(promoter: promoter)
      expect(event.reload.promoters).to contain_exactly(promoter)
    end

    it "add person as promoter" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      person = Person.create!
      event = Events::Event.create!(promoter: person)
      expect(event.promoters.reload.size).to eq(1)
      expect(event.promoters.first.person).to eq(person)
    end

    it "accepts nil" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      event = Events::Event.create!(promoter: nil)
      expect(event.reload.promoters).to be_empty
    end
  end

  describe ".current_year" do
    it "only finds events that starts_at in the current year" do
      Events::Event.create!(starts_at: 1.year.ago.end_of_year)
      Events::Event.create!(starts_at: 1.year.from_now.end_of_year)
      event = Events::Event.create!(starts_at: Time.current)
      expect(Events::Event.current_year).to eq([ event ])
    end
  end

  describe "#promoter_names" do
    it "returns array if there is no promoter" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      event = Events::Event.create!
      expect(event.promoter_names).to eq([])
    end

    it "returns promoter names" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      event = Events::Event.create!
      event.promoters << Events::Promoter.new(person: Person.create!(name: "David Hart"))
      event.promoters << Events::Promoter.new(person: Person.create!(name: "David Saltzberg"))
      expect(event.reload.promoter_names).to contain_exactly("David Hart", "David Saltzberg")
    end
  end
end
