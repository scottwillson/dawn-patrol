module Events
  class FindAll
    def initialize(attributes = {})
      @discipline = attributes[:discipline]
      @year = attributes[:year]
    end

    def do_it!
      query = Event
        .includes(promoters: :person)
        .where(starts_at: DawnPatrol::Association.current.year_range(@year))

      if @discipline && @discipline != "all"
        query = query.where(discipline: Discipline.where(slug: @discipline).first!)
      end

      query
    end
  end
end
