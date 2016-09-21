require "rails_helper"

RSpec.describe "Calculations::Steps::MapSelectionsToResults" do
  describe ".map" do
    it "accepts empty collection" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      Calculations::Steps::MapSelectionsToResults.do_step([], category: Events::Category.new)
    end

    it "maps selections to results" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      category = Events::Category.new
      results = Calculations::Steps::MapSelectionsToResults.do_step(
        [ Calculations::Selection.new, Calculations::Selection.new ],
        category: category
      )
      expect(results.size).to eq(1)
    end
  end
end
