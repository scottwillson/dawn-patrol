class EventsController < ApplicationController
  def index
    @year = year(params)
    @last_updated_event = Event.year(@year).order(:updated_at).last

    if stale?(@last_updated_event)
      respond_to do |format|
        format.html
        format.json do
          render json: events_as_json
        end
      end
    end
  end

  private

  def year(params)
    year = params[:year]&.to_i
    return year if year && year > 1900

    DawnPatrol::Association.current.year
  end

  def events_as_json
    years = (Event.years << @year).uniq
    Rails.cache.fetch([ @last_updated_event&.cache_key, years, @year ]) do
      events = Events::FindAll.new(discipline: @discipline, year: @year).do_it!

      {
        link_groups: link_groups(events, years, @year),
        events: events.as_json(methods: :promoter_names),
        year: @year,
        years: years
      }
    end
  end

  def link_groups(events, years, year)
    [
      {
        slug: "discipline",
        links: Discipline.find(events.map(&:discipline_id).uniq).map { |d| { slug: d.slug, name: d.name } },
        selected: params[:discipline],
        all: true
      },
      {
        slug: "year",
        links: years,
        selected: year
      }
    ]
  end
end
