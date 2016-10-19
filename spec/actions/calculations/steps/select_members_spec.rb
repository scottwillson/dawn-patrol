require "rails_helper"

RSpec.describe "Calculations::Steps::SelectMembers" do
  describe "default" do
    it "rejects no one" do
      DawnPatrol::Association.current = DawnPatrol::Association.new

      result = ::Result.new
      source_results = [ result ]

      calculation = Calculations::Calculation.new
      results = Calculations::Steps::SelectMembers.do_step(source_results, calculation)

      expect(results).to eq([ result ])
    end
  end

  describe "members_only" do
    it "only selects members" do
      DawnPatrol::Association.current = DawnPatrol::Association.new

      non_member_result = ::Result.new
      member = Person.new
      member.memberships << Membership.new
      member_result = ::Result.new(person: member)
      source_results = [ non_member_result, member_result ]

      calculation = Calculations::Calculation.new(members_only: true)
      results = Calculations::Steps::SelectMembers.do_step(source_results, calculation)

      expect(results).to eq([ member_result ])
    end
  end
end
