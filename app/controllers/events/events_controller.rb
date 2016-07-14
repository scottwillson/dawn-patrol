class Events::EventsController < ApplicationController
  def index
    @year = params[:year]

    respond_to do |format|
      format.html
      format.json do
        events = Events::FindAll.new(year: @year).do_it!
        render json: events.as_json(methods: :promoter_names)
      end
    end
  end
end
