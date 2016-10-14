class Events::ResultsController < ApplicationController
  def index
    @event = Events::Event.find(params[:event_id])

    respond_to do |format|
      format.html
      format.json do
        render json: results.as_json(include: { categories: { include: [ :category, { results: { include: :person } } ] } })
      end
    end
  end

  def results
    Events::FindResults.new(id: params[:event_id]).do_it!
  end
end
