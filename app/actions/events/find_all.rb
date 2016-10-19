module Events
  class FindAll
    def initialize(attributes = {})
      @year = attributes[:year]
    end

    def do_it!
      Event
        .includes(promoters: :person)
        .where(starts_at: DawnPatrol::Association.current.year_range(@year))
    end
  end
end
