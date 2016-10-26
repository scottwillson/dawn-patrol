module Events
  class FindAll
    def initialize(attributes = {})
      @discipline = attributes[:discipline]
      @year = attributes[:year]
    end

    def do_it!
      query = Event
        .includes(:discipline)
        .includes(promoters: :person)
        .where(starts_at: DawnPatrol::Association.current.year_range(@year))

      # TODO use slugs
      # TODO make All an option for nav?
      if @discipline && @discipline != "All"
        query = query.where(discipline: Discipline.where(name: @discipline).first!)
      end

      query
    end
  end
end
