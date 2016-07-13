class Events::EventsController < ApplicationController
  def index
    @year = params[:year]
    
    respond_to do |format|
      format.html
      format.json { render json: Events::FindAll.new(year: @year).do_it! }
    end
  end
end
