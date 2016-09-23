require "rails_helper"

RSpec.describe "Calculations::Calculate" do
  before(:each) do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
  end

  describe "default Calculation" do
    it "calculates results" do
      event = Events::Event.create!(starts_at: 1.year.ago)
      category = Category.create!(name: "Senior Women")
      event_category = event.categories.create!(category: category)
      last_year_result = event_category.results.create!(person: Person.create!)

      event = Events::Event.create!(starts_at: 1.year.from_now)
      category = Category.create!(name: "Junior Men")
      event_category = event.categories.create!(category: category)
      next_year_result = event_category.results.create!(person: Person.create!)

      event = Events::Event.create!
      category = Category.create!
      event_category = event.categories.create!(category: category)
      source_result = event_category.results.create!(person: Person.create!)
      result_without_participant = event_category.results.create!

      calculation = Calculations::Calculation.create!(name: "Ironman")

      action_result = Calculations::Calculate.new(calculation: calculation).do_it!
      expect(action_result).to be(true)

      expect(calculation.events.count).to eq(1)

      calculated_event = calculation.events.first
      expect(calculated_event.categories.count).to eq(1)

      category = calculated_event.categories.first
      expect(category.results.count).to eq(1)

      result = category.results.first
      expect(result.calculations_selections.count).to eq(1)
      expect(result.points).to eq(1)

      calculation_selection = result.calculations_selections.reload.first
      expect(calculation_selection.points).to eq(1)
      expect(calculation_selection.source_result).to eq(source_result)
      expect(calculation_selection.calculated_result).to eq(result)

      expect(source_result.calculations_rejections.reload.count).to eq(0)
      expect(last_year_result.calculations_rejections.reload.count).to eq(0)
      expect(next_year_result.calculations_rejections.reload.count).to eq(0)

      expect(result_without_participant.calculations_rejections.reload.count).to eq(1)
      rejection = result_without_participant.calculations_rejections.first
      expect(rejection.event).to eq(calculated_event)
      expect(rejection.reason).to eq("no_person")
    end

    it "calculates with no results" do
      calculation = Calculations::Calculation.create!

      result = Calculations::Calculate.new(calculation: calculation).do_it!
      expect(result).to be(true)
    end
  end

  describe "create_event" do
    it "creates a calculated Event" do
      calculation = Calculations::Calculation.create!(name: "Ironman")
      calculate = Calculations::Calculate.new(calculation: calculation)

      event = calculate.create_event

      expect(event.calculation).to eq(calculation)
      expect(event.calculated?).to be(true)
      expect(event.name).to eq("Ironman")
      expect(event).to be_valid
    end
  end

  describe "create_category" do
    it "creates an event category" do
      calculation = Calculations::Calculation.create!(name: "Ironman")
      calculate = Calculations::Calculate.new(calculation: calculation)

      event = calculate.create_event
      category = calculate.create_category(event)
      expect(category).to be_valid
      expect(category.name).to eq("Ironman")
    end
  end

  describe "#save_results" do
    it "persists results" do
      event = Events::Event.create!
      category = Category.create!
      event_category = event.categories.create!(category: category)
      event_category.results.create!(person: Person.create!)
      event_category.results.create!(person: Person.create!)

      calculation = Calculations::Calculation.create!
      calculate = Calculations::Calculate.new(calculation: calculation)
      calculation_event = calculate.create_event
      calculation_category = calculate.create_category(calculation_event)

      results = [
        Result.new(event_category: calculation_category),
        Result.new(event_category: calculation_category)
      ]

      calculate.save_results results
      expect(results).to all(be_valid)
      expect(results).to all(be_persisted)
    end
  end
end
