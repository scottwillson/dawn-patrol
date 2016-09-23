require "rails_helper"

RSpec.describe "Calculations::Steps::MapSelectionsToResults" do
  describe ".do_step" do
    it "accepts empty collection" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      calculation = Calculations::Calculation.new
      Calculations::Steps::MapSelectionsToResults.do_step([], calculation)
    end

    it "maps selections to results" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      calculation = Calculations::Calculation.new
      results = Calculations::Steps::MapSelectionsToResults.do_step(
        [ Calculations::Selection.new, Calculations::Selection.new ],
        calculation
      )
      expect(results.size).to eq(1)
    end
  end
end
