require "rails_helper"

RSpec.describe "Calculations::Calculate" do
  it "calculates results" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!

    event = Events::Event.create!
    category = Category.create!
    event_category = event.categories.create!(category: category)
    source_result = event_category.results.create!(person: Person.create!)

    calculation = Calculations::Calculation.create!(name: "Ironman")

    action_result = Calculations::Calculate.new(calculation: calculation).do_it!
    expect(action_result).to be(true)

    expect(calculation.events.count).to eq(1)

    calculated_event = calculation.events.first
    expect(calculated_event.calculated?).to be(true)
    expect(calculated_event.categories.count).to eq(1)
    expect(calculated_event.name).to eq("Ironman")

    category = calculated_event.categories.first
    expect(category.name).to eq("Ironman")
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

    # event with results
    # results have scores (name?)
    # filter results
    # report exceptions
    # handle excluded events
    # re-use existing events
    # re-use categories
    # parameterize year
    # include year in calculation event name?
    # check performance (DB queries) with real data
    # assert result name and team
  end

  it "calculates with no results" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    calculation = Calculations::Calculation.create!

    result = Calculations::Calculate.new(calculation: calculation).do_it!
    expect(result).to be(true)
  end
end
