module Calculations
  class Calculate
    def initialize(attributes = {})
      @calculation = attributes[:calculation]
    end

    def do_it!
      event = create_event
      category = create_category(event)
      source_results = Result.current_year

      selections = Steps::MapResultsToSelections.map(source_results)
      results    = Steps::MapSelectionsToResults.map(selections, category)

      save_results results

      true
    end

    def create_event
      @calculation.events.create!(name: @calculation.name)
    end

    def create_category(event)
      event.categories.create!(category: Category.create!(name: @calculation.name))
    end

    def save_results(results)
      results.each(&:save!)
    end
  end
end
