require "rails_helper"

RSpec.describe "Calculations::Steps::MapResultsToSelections" do
  describe ".map" do
    it "maps empty collection" do
      Calculations::Steps::MapResultsToSelections.map([])
    end

    it "maps results" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      selections = Calculations::Steps::MapResultsToSelections.map([ Result.new, Result.new ])
      expect(selections.size).to eq(2)
    end
  end
end
