module Calculations
  module Steps
    module SelectInSourceEvent
      def self.do_step(results, calculation)
        results.select do |result|
          result.event.in?(calculation.source_events)
        end
      end

      def self.rejection_reason
        :not_a_source_event
      end
    end
  end
end
