module Calculations
  module Steps
    module RejectParentSourceEvent
      def self.do_step(results, calculation)
        results.reject(&:event_parent?)
      end

      def self.rejection_reason
        :parent_source_event
      end

      def self.type
        :reject
      end
    end
  end
end
