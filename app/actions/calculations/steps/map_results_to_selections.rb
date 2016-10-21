module Calculations
  module Steps
    module MapResultsToSelections
      def self.do_step(source_results, _)
        source_results.map do |result|
          Calculations::Selection.new(
            points: 1,
            source_result: result
          )
        end
      end

      def self.type
        :map
      end
    end
  end
end
