require "rails_helper"

RSpec.describe "Calculations::Calculate" do
  before(:each) do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
  end

  it "calculates results" do
    event = Events::Event.create!
    category = Category.create!
    event_category = event.categories.create!(category: category)
    source_result = event_category.results.create!(person: Person.create!)

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

    calculation_selection = result.calculations_selections.first
    expect(calculation_selection.points).to eq(1)
    expect(calculation_selection.source_result).to eq(source_result)
    expect(calculation_selection.calculated_result).to eq(result)

    source_result.reload
    expect(source_result.calculations_rejections.count).to eq(0)
  end

  it "calculates with no results" do
    calculation = Calculations::Calculation.create!

    result = Calculations::Calculate.new(calculation: calculation).do_it!
    expect(result).to be(true)
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

  describe "#create_results" do
    it "persists results from selections" do
      event = Events::Event.create!
      category = Category.create!
      event_category = event.categories.create!(category: category)
      source_result = event_category.results.create!(person: Person.create!)
      source_result_2 = event_category.results.create!(person: Person.create!)

      calculation = Calculations::Calculation.create!
      calculate = Calculations::Calculate.new(calculation: calculation)
      calculation_event = calculate.create_event
      calculation_category = calculate.create_category(calculation_event)

      selections = [
        Calculations::Selection.new(points: 1, source_result: source_result),
        Calculations::Selection.new(points: 1, source_result: source_result_2)
      ]

      results = calculate.create_results(selections, calculation_category)
      expect(results.size).to eq(2)
    end
  end
end
