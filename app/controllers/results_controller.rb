class ResultsController < ApplicationController
  def index
    @event = Event.includes(:children, :parent).find(params[:event_id])

    respond_to do |format|
      format.html
      format.json do
        render json: results_as_json
      end
    end
  end

  def results
    Events::FindResults.new(event_id: params[:event_id]).do_it!
  end

  def results_as_json
    Rails.cache.fetch(@event.cache_key) do
      results.as_json({ include: [ :category, { results: { include: :person, methods: :numeric_place } } ] })
    end
  end
end
