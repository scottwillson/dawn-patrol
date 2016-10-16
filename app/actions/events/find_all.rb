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
        beginning_of_year = Time.zone.local(@year).beginning_of_year
        beginning_of_year..beginning_of_year.end_of_year
      else
        Time.current.beginning_of_year..Time.current.end_of_year
      end
    end
  end
end
