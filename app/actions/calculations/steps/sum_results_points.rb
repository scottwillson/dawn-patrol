module Calculations
  module Steps
    module SumResultsPoints
      def self.do_step(results, calculation)
        results.each do |result|
          result.points = result
                          .calculations_selections
                          .map(&:points)
                          .sum
        end
      end

      def self.type
        :map
      end
    end
  end
end
