require "rails_helper"

RSpec.describe "Calculations::Steps::MapSelectionsToResults" do
  describe ".do_step" do
    it "accepts empty collection" do
      calculation = Calculations::Calculation.new
      Calculations::Steps::MapSelectionsToResults.do_step([], calculation)
    end

    it "maps selections to results" do
      calculation = Calculations::Calculation.new
      results = Calculations::Steps::MapSelectionsToResults.do_step(
        [ Calculations::Selection.new, Calculations::Selection.new ],
        calculation
      )
      expect(results.size).to eq(1)
    end

    it "groups selections by person" do
      person_1 = Person.new(id: 1)
      person_2 = Person.new(id: 2)

      person_1_result_1 = Result.new(person: person_1)
      person_1_result_2 = Result.new(person: person_1)
      person_2_result_1 = Result.new(person: person_2)

      person_1_selection_1 = Calculations::Selection.new(source_result: person_1_result_1)
      person_1_selection_2 = Calculations::Selection.new(source_result: person_1_result_2)
      person_2_selection_1 = Calculations::Selection.new(source_result: person_2_result_1)

      selections = [ person_1_selection_1, person_1_selection_2, person_2_selection_1 ]

      results = Calculations::Steps::MapSelectionsToResults.do_step(selections, {})

      expect(results.size).to eq(2)
      expect(results.one? { |r| r.calculations_selections.size == 2 })
      expect(results.one? { |r| r.calculations_selections.size == 1 })
    end
  end
end
