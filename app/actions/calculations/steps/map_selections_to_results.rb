module Calculations
  module Steps
    class MapSelectionsToResults
      def self.map(selections, category)
        selections.group_by(&:person_id).map do |person_id, person_selections|
          Result.new(
            calculations_selections: person_selections,
            event_category: category,
            person_id: person_id,
            points: person_selections.map(&:points).inject(:+)
          )
        end
      end
    end
  end
end
