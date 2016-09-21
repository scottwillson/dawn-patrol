module Calculations
  class Calculate
    def initialize(attributes = {})
      @calculation = attributes[:calculation]
    end

    def do_it!
      Calculation.benchmark("#{self.class} do_it calculation: #{@calculation.name}", level: :debug) do
        Calculation.transaction do
          event = create_event
          category = create_category(event)

          result = Calculations::Steps::Result.new(source_results, category: category)
                     .do_step(Steps::MapResultsToSelections)
                     .do_step(Steps::MapSelectionsToResults)

          save_results result.results
        end
      end

      true
    end

    def source_results
      Calculation.benchmark("#{self.class} source_results calculation: #{@calculation.name}", level: :debug) do
        Result.current_year
      end
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
