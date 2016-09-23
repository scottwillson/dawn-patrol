module Calculations
  class Calculate
    def initialize(attributes = {})
      @calculation = attributes[:calculation]
    end

    def do_it!
      Calculation.benchmark("#{self.class} do_it calculation: #{@calculation.name}", level: :debug) do
        Calculation.transaction do
          event = create_event
          create_categories event

          result = Steps::Result.new(source_results, [], @calculation)
                     .do_step(Steps::SelectParticipants)
                     .do_step(Steps::SelectPlaced)
                     .do_step(Steps::RejectDnfs)
                     .do_step(Steps::MapResultsToSelections)
                     .do_step(Steps::MapSelectionsToResults)

          save_results result.results, event
          save_rejections result.rejections, event
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

    def create_categories(event)
      @calculation.categories.each do |category|
        event.categories.create!(category: category)
      end
    end

    def save_results(results, event)
      Calculation.benchmark("#{self.class} save_results calculation: #{@calculation.name}", level: :debug) do
        results.each do |result|
          event.categories.first.results << result
        end
      end
    end

    def save_rejections(rejections, event)
      Calculation.benchmark("#{self.class} save_rejections calculation: #{@calculation.name}", level: :debug) do
        rejections.each do |rejection|
          rejection.event = event
          rejection.save!
        end
      end
    end
  end
end
