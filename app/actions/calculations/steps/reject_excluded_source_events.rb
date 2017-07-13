module Calculations
  module Steps
    module RejectExcludedSourceEvents
      def self.do_step(results, calculation)
        results.reject do |result|
          result.event_id.in?(calculation.excluded_source_event_ids)
        end
      end

      def self.rejection_reason
        :excluded_source_event
      end

      def self.type
        :reject
      end
    end
  end
end
