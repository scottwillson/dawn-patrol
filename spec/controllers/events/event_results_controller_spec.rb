require "rails_helper"

RSpec.describe Events::ResultsController, type: :controller do
  before(:each) do
    save_default_current_association!
  end

  describe "#index" do
    it "responds with html" do
      event = Events::Create.new.do_it!
      get :index, params: { event_id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it "responds with json" do
      event = Events::Create.new.do_it!
      get :index, params: { event_id: event.id }, format: :json
    end
  end
end
