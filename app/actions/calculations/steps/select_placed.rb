module Calculations
  module Steps
    module SelectPlaced
      def self.do_step(results, _)
        results.select(&:placed?)
      end

      def self.rejection_reason
        :no_place
      end
      
      def self.type
        :select
      end
    end
  end
end
