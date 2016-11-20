class EventsController < ApplicationController
  def index
    @year = (params[:year] || DawnPatrol::Association.current.year).to_i

    respond_to do |format|
      format.html
      format.json do
        events = Events::FindAll.new(discipline: @discipline, year: @year).do_it!

        render json: {
          link_groups: link_groups(events, Event.years, @year),
          events: events.as_json(methods: :promoter_names),
          year: @year
        }
      end
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
