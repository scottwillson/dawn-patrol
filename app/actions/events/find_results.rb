module Events
  class FindResults
    def initialize(attributes = {})
      @event_id = attributes[:event_id]
    end

    def do_it!
      ::EventCategory.where(event_id: @event_id).includes(results: :person).includes(:category)
    end
  end
end
