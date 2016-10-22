module Calculations
  module Steps
    module Place
      def self.do_step(results, _)
        results.each.with_index do |result, index|
          result.place = (index + 1).to_s
        end
      end

      def self.type
        :map
      end
    end
  end
end
