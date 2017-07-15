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
                     .do_step(Steps::RejectExcludedSourceEvents)
                     .do_step(Steps::RejectParentSourceEvent)
                     .do_step(Steps::MapResultsToSelections)
                     .do_step(Steps::MapSelectionsToResults)
                     .do_step(Steps::AssignSelectionsPoints)
                     .do_step(Steps::SumResultsPoints)
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
        add_event_parent year_results
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
        calculation_category = Categories::Create.new(name: @calculation.name).do_it!
        @calculation.categories << calculation_category
      end

      if event.event_categories.empty?
        @calculation.categories.each do |category|
          event.event_categories.create!(category: category)
        end
      end
    end

    def save_results(results, event)
      Calculation.benchmark("#{self.class} save_results calculation: #{@calculation.name}, results: #{results.size}", level: :debug) do
        results.each do |result|
          event_category = event.event_categories.first
          existing_result = event_category.results.where(person_id: result.person_id).first

          if existing_result
            existing_result.update! points: result.points, place: result.place
          else
            result.event_category = event_category
            result.calculations_selections.select(&:new_record?).each { |selection| selection.calculated_result = result }
            # Trigger exception if invalid
            result.save!
          end
        end
      end
    end

    def save_rejections(rejections, event)
      Calculation.benchmark("#{self.class} save_rejections calculation: #{@calculation.name}, rejections: #{rejections.size}", level: :debug) do
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

    def year_results
      Calculation.benchmark("#{self.class} year_results calculation: #{@calculation.name}", level: :debug) do
        Result
          .includes(event_category: :event)
          .year(@year)
          .readonly!
      end
    end

    def add_event_parent(results)
      event_ids = results.map(&:event_id).uniq
      parent_ids = ::Event.where(id: event_ids).joins(:children).pluck(:id).uniq
      results.each do |result|
        result.event_parent = result.event_id.in?(parent_ids)
      end
    end
  end
end
