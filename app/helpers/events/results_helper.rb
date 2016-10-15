module Events::ResultsHelper
  def title
    if @event
      "#{@event.dawn_patrol_association.acronym}: #{@event.starts_at.year} Results: #{@event.name}"
    else
      default_title
    end
  end
end
