require "rails_helper"

RSpec.describe Event, type: :model do
  before(:each) do
    save_default_current_association!
  end

  it "has many promoters" do
    promoter = Events::Promoter.new(person: Person.create!)
    promoter_2 = Events::Promoter.new(person: Person.create!)
    event = Events::Create.new(promoters: [ promoter, promoter_2 ]).do_it!
    expect(event.reload.promoters.map(&:person)).to contain_exactly(promoter.person, promoter_2.person)
  end

  describe "#promoter=" do
    it "adds promoter" do
      promoter = Events::Promoter.new(person: Person.create!)
      event = Events::Create.new(promoter: promoter).do_it!
      expect(event.reload.promoters).to contain_exactly(promoter)
    end

    it "add person as promoter" do
      person = Person.create!
      event = Events::Create.new(promoter: person).do_it!
      expect(event.promoters.reload.size).to eq(1)
      expect(event.promoters.first.person).to eq(person)
    end

    it "accepts nil" do
      event = Events::Create.new(promoter: nil).do_it!
      expect(event.reload.promoters).to be_empty
    end
  end

  describe ".current_year" do
    it "only finds events that starts_at in the current year" do
      Events::Create.new(starts_at: 1.year.ago.end_of_year).do_it!
      Events::Create.new(starts_at: 1.year.from_now.end_of_year).do_it!
      event = Events::Create.new(starts_at: Time.current).do_it!
      expect(Event.current_year).to eq([ event ])
    end
  end

  describe "#promoter_names" do
    it "returns array if there is no promoter" do
      event = Events::Create.new.do_it!
      expect(event.promoter_names).to eq([])
    end

    it "returns promoter names" do
      event = Events::Create.new.do_it!
      event.promoters << Events::Promoter.new(person: Person.create!(name: "David Hart"))
      event.promoters << Events::Promoter.new(person: Person.create!(name: "David Saltzberg"))
      expect(event.reload.promoter_names).to contain_exactly("David Hart", "David Saltzberg")
    end
  end
end
