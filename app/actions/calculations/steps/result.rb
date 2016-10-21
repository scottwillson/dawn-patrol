module Calculations
  module Steps
    class Result
      attr_reader :rejections
      attr_reader :results

      def initialize(results, rejections, calculation)
        raise(ArgumentError, "rejections cannot be nil") unless rejections
        raise(ArgumentError, "results cannot be nil") unless results
        raise(ArgumentError, "calculation cannot be nil") unless calculation

        @calculation = calculation
        @rejections = rejections
        @results = results
      end

      def do_step(step_class)
        Calculation.benchmark("Calculations::Steps::#{step_class} do_step", level: :debug) do
          before = @results.dup
          results = step_class.do_step(@results, @calculation)
          @rejections = @rejections + new_rejections(before, results, step_class)

          Steps::Result.new(results, @rejections, @calculation)
        end
      end

      def new_rejections(before, after, step_class)
        Rails.logger.debug("Calculations::Steps::#{step_class} results: #{before.size} -> #{after.size}")

        return [] if step_class.type == :map || before.size == after.size

        rejected_results(before, after).map do |result|
          Calculations::Rejection.new(reason: step_class.rejection_reason, result: result)
        end
      end

      def rejected_results(before, after)
        (before - after).map do |result|
          case result
          when ::Result
            result
          when Calculations::Selection
            result.source_result
          else
            raise(ArgumentError, "Expected ::Result or Calculations::Selection")
          end
        end
      end
    end
  end
end
