class Events::EventsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Events::Event.all }
    end
  end
end
