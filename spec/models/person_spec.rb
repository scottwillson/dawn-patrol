require "rails_helper"

RSpec.describe Person, type: :model do
  before(:each) do
    save_default_current_association!
  end

  it "creates unamed Person" do
    person = Person.create!
    expect(person.name).to eq(nil)
  end

  describe "#member?" do
    it "considers memberships" do
      person = Person.new
      expect(person.member?).to be(false)

      person.memberships << Memberships::New.new(
        start_at: 2.years.ago,
        end_at: 1.year.ago.end_of_year
      ).do_it!

      expect(person.member?).to be(false)

      person.memberships << Memberships::New.new(
        start_at: Time.current.beginning_of_year,
        end_at: Time.current.end_of_year
      ).do_it!

      expect(person.member?).to be(true)
    end
  end
end
