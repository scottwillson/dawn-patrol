module Calculations
  class Calculate
    def initialize(attributes = {})
      @calculation = attributes[:calculation]
      @year = attributes[:year]
    end

    def do_it!
      Calculation.benchmark("#{self.class} do_it calculation: #{@calculation.name}", level: :debug) do
        Calculation.transaction do
          event = find_or_create_event
          create_categories event

          result = Steps::Result.new(source_results, [], @calculation)
                     .do_step(Steps::SelectParticipants)
                     .do_step(Steps::SelectPlaced)
                     .do_step(Steps::RejectDnfs)
                     .do_step(Steps::SelectMembers)
                     .do_step(Steps::SelectInSourceEvent)
                     .do_step(Steps::MapResultsToSelections)
                     .do_step(Steps::MapSelectionsToResults)
                     .do_step(Steps::Sort)
                     .do_step(Steps::Place)

          save_results result.results, event
          save_rejections result.rejections, event
        end
      end

      true
    end

    def source_results
      Calculation.benchmark("#{self.class} source_results calculation: #{@calculation.name}", level: :debug) do
        Result
          .includes(event_category: :event)
          .year(@year)
          .readonly!
      end
    end

    def find_or_create_event
      @calculation.events.where(starts_at: DawnPatrol::Association.current.year_range(@year)).first ||
        Events::Create.new(
          calculation: @calculation,
          name: @calculation.name,
          starts_at: DawnPatrol::Association.current.beginning_of_year(@year)
        ).do_it!
    end

    def create_categories(event)
      if @calculation.categories.empty?
        @calculation.categories.create!(name: @calculation.name)
      end

      if event.event_categories.empty?
        @calculation.categories.each do |category|
          event.event_categories.create!(category: category)
        end
      end
    end

    def save_results(results, event)
      Calculation.benchmark("#{self.class} save_results calculation: #{@calculation.name}", level: :debug) do
        results.each do |result|
          existing_result = event.event_categories.first.results.where(person_id: result.person_id).first

          if existing_result
            existing_result.update!(points: result.points, place: result.place)
          else
            event.event_categories.first.results << result
          end
        end
      end
    end

    def save_rejections(rejections, event)
      Calculation.benchmark("#{self.class} save_rejections calculation: #{@calculation.name}", level: :debug) do
        rejections.each do |rejection|
          existing_rejection = event.rejections.where(result: rejection.result).first

          if existing_rejection
            existing_rejection.reason = rejection.reason
            existing_rejection.save!
          else
            rejection.event = event
            rejection.save!
          end
        end
      end
    end
  end
end
