require "rails_helper"

RSpec.describe "Calculations::Steps::AssignSelectionsPoints" do
  describe ".do_step" do
    it "assigns default points" do
      source_result = ::Result.new
      selection = Calculations::Selection.new(source_result: source_result)
      result = ::Result.new(calculations_selections: [ selection ])

      results = Calculations::Steps::AssignSelectionsPoints.do_step([ result ], Calculations::Calculation.new)

      expect(results.size).to eq(1)
      result = results.first
      expect(result.calculations_selections.size).to eq(1)
      expect(result.calculations_selections.first.points).to eq(1)
    end

    it "uses Calculation#points" do
      source_result = ::Result.new(place: 2)
      selection = Calculations::Selection.new(source_result: source_result)
      result = ::Result.new(calculations_selections: [ selection ])
      calculation = Calculations::Calculation.new(points: [ 5, 3, 1 ])

      results = Calculations::Steps::AssignSelectionsPoints.do_step([ result ], calculation)

      expect(results.size).to eq(1)
      result = results.first
      expect(result.calculations_selections.size).to eq(1)
      expect(result.calculations_selections.first.points).to eq(3)
    end
  end
end
