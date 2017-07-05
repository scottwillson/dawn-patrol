require "rails_helper"

RSpec.describe "Calculations::Calculate" do
  before(:each) do
    save_default_current_association!
  end

  describe "default Calculation" do
    it "calculates results" do
      event = Events::Create.new(starts_at: 1.year.ago).do_it!
      category = Category.create!(name: "Senior Women")
      event_category = event.event_categories.create!(category: category)
      last_year_result = event_category.results.create!(person: Person.create!, place: "1")

      event = Events::Create.new(starts_at: 1.year.from_now).do_it!
      category = Category.create!(name: "Junior Men")
      event_category = event.event_categories.create!(category: category)
      next_year_result = event_category.results.create!(person: Person.create!, place: "2")

      event = Events::Create.new.do_it!
      category = Category.create!
      event_category = event.event_categories.create!(category: category)
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
      expect(calculated_event.event_categories.count).to eq(1)

      category = calculated_event.event_categories.first
      expect(category.results.count).to eq(1)

      result = category.results.first
      expect(result.calculations_selections.count).to eq(1)
      expect(result.points).to eq(1)
      expect(result.place).to eq("1")

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

      # idempotent
      calculation.reload
      action_result = Calculations::Calculate.new(calculation: calculation).do_it!
      expect(action_result).to be(true)
      calculation.reload
      expect(calculation.events.count).to eq(1)

      calculated_event = calculation.events.first
      expect(calculated_event.event_categories.count).to eq(1)

      category = calculated_event.event_categories.first
      expect(category.results.count).to eq(1)
    end

    it "calculates results from previous year" do
      event = Events::Create.new(starts_at: 1.year.ago).do_it!
      category = Category.create!
      event_category = event.event_categories.create!(category: category)
      source_result = event_category.results.create!(person: Person.create!, place: "3")

      calculation = Calculations::Calculation.create!(name: "Ironman")

      action_result = Calculations::Calculate.new(calculation: calculation, year: 1.year.ago.year).do_it!
      expect(action_result).to be(true)

      expect(calculation.events.count).to eq(1)
      calculated_event = calculation.events.first
      category = calculated_event.event_categories.first
      result = category.results.first
      calculation_selection = result.calculations_selections.reload.first
      expect(calculation_selection.source_result).to eq(source_result)
    end

    it "calculates with no results" do
      calculation = Calculations::Calculation.create!
      result = Calculations::Calculate.new(calculation: calculation).do_it!
      expect(result).to be(true)
    end

    it "calculates with multiple results for same person" do
      event = Events::Create.new.do_it!
      category = Category.create!
      event_category = event.event_categories.create!(category: category)
      person = Person.create!
      event_category.results.create!(person: person, place: "3")
      event_category.results.create!(person: Person.create!, place: "4")

      event = Events::Create.new.do_it!
      category = Category.create!(name: "Men 4/5")
      event_category = event.event_categories.create!(category: category)
      event_category.results.create!(person: person, place: "1")

      calculation = Calculations::Calculation.create!(name: "Ironman")

      action_result = Calculations::Calculate.new(calculation: calculation).do_it!
      expect(action_result).to be(true)

      calculated_result = calculation.events.first.event_categories.first.results.where(person: person).first!
      expect(calculated_result.calculations_selections.size).to eq(2)
    end
  end

  describe "#source_event_ids" do
    it "defaults to all events" do

      calculation = Calculations::Calculation.create!

      events = [
        Events::Create.new(starts_at: 1.year.ago.end_of_year).do_it!,
        Events::Create.new(starts_at: 1.year.from_now.end_of_year).do_it!,
        Events::Create.new(starts_at: Time.current).do_it!
      ]

      expect(calculation.source_event_ids).to eq(events.map(&:id))
    end
  end

  describe "find_or_create_event" do
    it "creates a calculated Event" do
      calculation = Calculations::Calculation.create!(name: "Ironman")
      calculate = Calculations::Calculate.new(calculation: calculation)

      event = calculate.find_or_create_event

      expect(event.calculation).to eq(calculation)
      expect(event.calculated?).to be(true)
      expect(event.name).to eq("Ironman")
      expect(event).to be_valid
    end

    it "creates a calculated Event in different year" do
      calculation = Calculations::Calculation.create!(name: "Ironman")

      calculate = Calculations::Calculate.new(calculation: calculation)
      calculate.find_or_create_event

      calculate = Calculations::Calculate.new(calculation: calculation, year: 2014)
      event = calculate.find_or_create_event
      event_2 = calculate.find_or_create_event

      expect(event).to eq(event_2)

      expect(calculation.events.reload.size).to eq(2)
      expect(calculation.events.map { |e| e.starts_at.year }).to match_array([ 2014, Time.current.year ])
    end
  end

  describe "create_categories" do
    it "creates an event category" do
      calculation = Calculations::Calculation.create!(name: "Ironman")
      calculate = Calculations::Calculate.new(calculation: calculation)

      event = calculate.find_or_create_event
      categories = calculate.create_categories(event)
      expect(categories).to all(be_valid)
      expect(categories.first.name).to eq("Ironman")
    end
  end

  describe "#save_results" do
    it "persists results" do
      event = Events::Create.new.do_it!
      category = Category.create!
      event_category = event.event_categories.create!(category: category)
      source_result_1 = event_category.results.create!(person: Person.create!)
      source_result_2 = event_category.results.create!(person: Person.create!)

      calculation = Calculations::Calculation.create!
      calculate = Calculations::Calculate.new(calculation: calculation)
      calculation_event = calculate.find_or_create_event
      calculate.create_categories(calculation_event)
      calculation_event_category = calculation_event.event_categories.reload.first

      selection_1 = Calculations::Selection.new(
        points: 1,
        source_result: source_result_1
      )

      selection_2 = Calculations::Selection.new(
        points: 1,
        source_result: source_result_2
      )

      result_1 = ::Result.new(
        calculations_selections: [ selection_1 ],
        person_id: source_result_1.person_id,
        points: 1
      )

      result_2 = ::Result.new(
        calculations_selections: [ selection_2 ],
        person_id: source_result_2.person_id,
        points: 1
      )

      results = [ result_1, result_2 ]

      calculate.save_results results, calculation_event
      expect(calculation_event_category.results.reload.count).to eq(2)
    end

    it "re-uses existing results" do
      event = Events::Create.new.do_it!
      category = Category.create!
      event_category = event.event_categories.create!(category: category)
      source_result_1 = event_category.results.create!(person: Person.create!)
      source_result_2 = event_category.results.create!(person: Person.create!)

      calculation = Calculations::Calculation.create!
      calculate = Calculations::Calculate.new(calculation: calculation)
      calculation_event = calculate.find_or_create_event
      calculate.create_categories(calculation_event)
      calculation_event_category = calculation_event.event_categories.reload.first

      result = calculation_event_category.results.create!(
        person_id: source_result_2.person_id,
        points: 1
      )
      result.calculations_selections.create!(points: 1, source_result: source_result_2)

      selection_1 = Calculations::Selection.new(
        points: 1,
        source_result: source_result_1
      )

      selection_2 = Calculations::Selection.new(
        points: 1,
        source_result: source_result_2
      )

      result_1 = ::Result.new(
        calculations_selections: [ selection_1 ],
        person_id: source_result_1.person_id,
        points: 1
      )

      result_2 = ::Result.new(
        calculations_selections: [ selection_2 ],
        person_id: source_result_2.person_id,
        points: 1
      )

      results = [ result_1, result_2 ]

      calculate.save_results results, calculation_event
      expect(calculation_event_category.results.reload.count).to eq(2)
    end
  end

  describe "#save_rejections" do
    it "saves and updates rejections" do
      source_event = Events::Create.new.do_it!
      event_category = source_event.event_categories.create!(category: Category.create!)
      result_1 = event_category.results.create!
      result_2 = event_category.results.create!

      calculation = Calculations::Calculation.create!
      calculated_event = Events::Create.new(calculation: calculation).do_it!
      existing_rejection = calculated_event.rejections.create!(result: result_1)

      calculate = Calculations::Calculate.new(calculation: calculation)
      rejections = [
        Calculations::Rejection.new(reason: :no_place, result: result_1),
        Calculations::Rejection.new(reason: :no_place, result: result_2),
      ]
      calculate.save_rejections(rejections, calculated_event)

      expect(Calculations::Rejection.exists?(existing_rejection.id)).to eq(true)
      expect(calculated_event.rejections.reload.count).to eq(2)
    end
  end
end
