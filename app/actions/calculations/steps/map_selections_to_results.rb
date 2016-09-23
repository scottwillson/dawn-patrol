module Calculations
  module Steps
    module MapSelectionsToResults
      def self.do_step(selections, _)
        selections.group_by(&:person_id).map do |person_id, person_selections|
          ::Result.new(
            calculations_selections: person_selections,
            person_id: person_id,
            points: person_selections.map(&:points).inject(:+)
          )
        end
      end
    end
  end
end
