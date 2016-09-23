module Calculations
  module Steps
    module SelectParticipants
      def self.do_step(results, _)
        results.select(&:person_id)
      end

      def self.rejection_reason
        :no_person
      end
    end
  end
end
