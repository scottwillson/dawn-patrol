require "rails_helper"

RSpec.describe "Calculations::Steps::SelectMembers" do
  describe "default" do
    it "rejects no one" do
      result = ::Result.new
      source_results = [ result ]

      calculation = Calculations::Calculation.new
      results = Calculations::Steps::SelectMembers.do_step(source_results, calculation)

      expect(results).to eq([ result ])
    end
  end

  describe "members_only" do
    it "only selects members" do
      non_member_result = ::Result.new
      member = Person.new
      member.memberships << Memberships::New.new.do_it!
      member_result = ::Result.new(person: member)
      source_results = [ non_member_result, member_result ]

      calculation = Calculations::Calculation.new(members_only: true)
      results = Calculations::Steps::SelectMembers.do_step(source_results, calculation)

      expect(results).to eq([ member_result ])
    end
  end
end
