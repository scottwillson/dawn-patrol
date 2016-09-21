module Calculations
  module Steps
    class Result
      attr_reader :results

      def initialize(results, options)
        @results = results
        @options = options
      end

      def do_step(step_class)
        Calculation.benchmark("Calculations::Steps::#{step_class} do_step", level: :debug) do
          before_count = @results.size
          results = step_class.do_step(@results, @options)
          after_count = @results.size

          Rails.logger.debug("Calculations::Steps::#{step_class} results: #{before_count} -> #{after_count}")

          Result.new(results, @options)
        end
      end
    end
  end
end
