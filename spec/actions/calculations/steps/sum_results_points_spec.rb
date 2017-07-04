require "rails_helper"

RSpec.describe "Calculations::Steps::SumResultsPoints" do
  describe ".do_step" do
    it "assigns default points" do
      source_result = ::Result.new
      selections = [
        Calculations::Selection.new(source_result: source_result, points: 3),
        Calculations::Selection.new(source_result: source_result, points: 1)
      ]

      result = ::Result.new(calculations_selections: selections)

      results = Calculations::Steps::SumResultsPoints.do_step([ result ], Calculations::Calculation.new)

      expect(results.size).to eq(1)
      expect(results.first.points).to eq(4)
    end
  end
end
