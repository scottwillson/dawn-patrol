class EventsController < ApplicationController
  def index
    @discipline = params[:discipline] || "All"
    @year = (params[:year] || DawnPatrol::Association.current.year).to_i

    respond_to do |format|
      format.html
      format.json do
        events = Events::FindAll.new(discipline: @discipline, year: @year).do_it!
        render json: {
          discipline: events.map(&:discipline).uniq.map(&:name),
          disciplines: Discipline.pluck(:name),
          events: events.as_json(methods: :promoter_names),
          year: @year,
          years: Event.years
        }
      end
    end
  end
end
