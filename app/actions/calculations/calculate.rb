module Calculations
  class Calculate
    def initialize(attributes = {})
      @calculation = attributes[:calculation]
    end

    def do_it!
      event = create_event
      category = create_category(event)
      source_results = Result.current_year
      selections = Steps::MapToSelections.map!(source_results)
      create_results selections, category

      true
    end

    def create_event
      @calculation.events.create!(name: @calculation.name)
    end

    def create_category(event)
      event.categories.create!(category: Category.create!(name: @calculation.name))
    end

    def create_results(selections, category)
      selections.each do |selection|
        selection.calculated_result = category.results.new(points: 1)
        selection.save!
      end
    end
  end
end
