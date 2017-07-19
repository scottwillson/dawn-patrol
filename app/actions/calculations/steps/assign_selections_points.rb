module Calculations
  module Steps
    module AssignSelectionsPoints
      def self.do_step(results, calculation)
        results.each do |result|
          result
            .calculations_selections
            .each { |selection| selection.points = points(selection.source_result, calculation) }
        end
      end

      def self.type
        :map
      end

      def self.points(source_result, calculation)
        if calculation.points.present?
          calculation.points[source_result.numeric_place - 1]
        else
          1
        end
      end
    end
  end
end
