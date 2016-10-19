module Events
  class FindAll
    def initialize(attributes = {})
      @year = attributes[:year]
    end

    def do_it!
      Event.includes(promoters: :person).where(starts_at: starts_at_range)
    end

    def starts_at_range
      if @year
        DawnPatrol::Association.current.beginning_of_year(@year)..DawnPatrol::Association.current.end_of_year(@year)
      else
        DawnPatrol::Association.current.beginning_of_year..DawnPatrol::Association.current.end_of_year
      end
    end
  end
end
