module Calculations
  module Steps
    module RejectDnfs
      def self.do_step(results, calculation)
        if calculation.dnf_points == 0
          results.reject(&:dnf?)
        else
          results
        end
      end

      def self.rejection_reason
        :dnf
      end

      def self.type
        :reject
      end
    end
  end
end
