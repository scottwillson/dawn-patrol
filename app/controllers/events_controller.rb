class EventsController < ApplicationController
  def index
    @year = (params[:year] || DawnPatrol::Association.current.year).to_i

    respond_to do |format|
      format.html
      format.json do
        events = Events::FindAll.new(year: @year).do_it!
        render json: {
          events: events.as_json(methods: :promoter_names),
          years: Event.years
        }
      end
    end
  end
end
