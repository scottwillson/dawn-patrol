module Calculations
  module Steps
    module Sort
      def self.do_step(results, _)
        results.sort_by(&:points).reverse
      end

      def self.type
        :sort
      end
    end
  end
end
