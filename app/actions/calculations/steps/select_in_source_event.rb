module Calculations
  module Steps
    module SelectInSourceEvent
      def self.do_step(results, calculation)
        results.select do |result|
          result.event_id.in?(calculation.source_event_ids)
        end
      end

      def self.rejection_reason
        :not_a_source_event
      end

      def self.type
        :select
      end
    end
  end
end
