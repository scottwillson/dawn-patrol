require "rails_helper"

RSpec.describe Person, type: :model do
  it "creates unamed Person" do
    DawnPatrol::Association.current = DawnPatrol::Association.create!
    person = Person.create!
    expect(person.name).to eq(nil)
  end

  describe "#member?" do
    it "considers memberships" do
      DawnPatrol::Association.current = DawnPatrol::Association.create!
      person = Person.new
      expect(person.member?).to be(false)

      person.memberships << Membership.new(start_at: 2.years.ago, end_at: 1.year.ago.end_of_year)
      expect(person.member?).to be(false)

      person.memberships << Membership.new(start_at: Time.current.beginning_of_year, end_at: Time.current.end_of_year)
      expect(person.member?).to be(true)
    end
  end
end
