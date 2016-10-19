require "rails_helper"

RSpec.describe "Calculations::Steps::MapResultsToSelections" do
  describe ".do_step" do
    it "maps empty collection" do
      Calculations::Steps::MapResultsToSelections.do_step([], {})
    end

    it "maps results" do
      selections = Calculations::Steps::MapResultsToSelections.do_step([ Result.new, Result.new ], {})
      expect(selections.size).to eq(2)
    end
  end
end
