module Calculations
  module Steps
    class MapResultsToSelections
      def self.map(source_results)
        source_results.map do |result|
          Calculations::Selection.new(
            points: 1,
            source_result: result
          )
        end
      end
    end
  end
end
