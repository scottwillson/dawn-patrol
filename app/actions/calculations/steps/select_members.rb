module Calculations
  module Steps
    module SelectMembers
      def self.do_step(results, calculation)
        if calculation.members_only?
          results.select(&:member?)
        else
          results
        end
      end

      def self.rejection_reason
        :not_a_member
      end
    end
  end
end
