require "rails_helper"

RSpec.describe "Calculations::Calculate" do
  before(:each) do
    DawnPatrol::Association.current = DawnPatrol::Association.create!
  end

  describe "default Calculation" do
    it "calculates results" do
      event = Events::Create.new(starts_at: 1.year.ago).do_it!
      category = Category.create!(name: "Senior Women")
      event_category = event.categories.create!(category: category)
      last_year_result = event_category.results.create!(person: Person.create!, place: "1")

      event = Events::Create.new(starts_at: 1.year.from_now).do_it!
      category = Category.create!(name: "Junior Men")
      event_category = event.categories.create!(category: category)
      next_year_result = event_category.results.create!(person: Person.create!, place: "2")

      event = Events::Create.new.do_it!
      category = Category.create!
      event_category = event.categories.create!(category: category)
      source_result = event_category.results.create!(person: Person.create!, place: "3")
      result_without_participant = event_category.results.create!(place: "4")
      event_category.results.create!(person: Person.create!, place: "")
      event_category.results.create!(person: Person.create!, place: "DQ")
      event_category.results.create!(person: Person.create!, place: "DNS")
      event_category.results.create!(person: Person.create!, place: "DNF")

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

  describe "#source_events" do
    it "defaults to all events in year" do

      calculation = Calculations::Calculation.create!

      Events::Create.new(starts_at: 1.year.ago.end_of_year).do_it!
      Events::Create.new(starts_at: 1.year.from_now.end_of_year).do_it!
      event = Events::Create.new(starts_at: Time.current).do_it!

      expect(calculation.source_events(Time.current.year)).to eq([ event ])
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

  describe "create_categories" do
    it "creates an event category" do
      calculation = Calculations::Calculation.create!(name: "Ironman")
      calculate = Calculations::Calculate.new(calculation: calculation)

      event = calculate.create_event
      categories = calculate.create_categories(event)
      expect(categories).to all(be_valid)
      expect(categories.first.name).to eq("Ironman")
    end
  end

  describe "#save_results" do
    it "persists results" do
      event = Events::Create.new.do_it!
      category = Category.create!
      event_category = event.categories.create!(category: category)
      event_category.results.create!(person: Person.create!)
      event_category.results.create!(person: Person.create!)

      calculation = Calculations::Calculation.create!
      calculate = Calculations::Calculate.new(calculation: calculation)
      calculation_event = calculate.create_event
      calculate.create_categories(calculation_event)

      results = [
        Result.new,
        Result.new
      ]

      calculate.save_results results, calculation_event
      expect(results).to all(be_valid)
      expect(results).to all(be_persisted)
    end
  end
end
