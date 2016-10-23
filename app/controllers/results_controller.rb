class ResultsController < ApplicationController
  def index
    @event = Event.includes(:children, :parent).find(params[:event_id])

    respond_to do |format|
      format.html
      format.json do
        render json: results.as_json({ include: [ :category, { results: { include: :person, methods: :numeric_place } } ] })
      end
    end
  end

  def results
    Events::FindResults.new(event_id: params[:event_id]).do_it!
  end
end
