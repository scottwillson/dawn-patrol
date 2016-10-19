require "rails_helper"

RSpec.describe Events::ResultsController, type: :controller do
  before(:each) do
    @default_association = DawnPatrol::Association.create!
  end

  describe "#index" do
    it "responds with html" do
      DawnPatrol::Association.current = @default_association
      event = Events::Create.new.do_it!
      get :index, params: { event_id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it "responds with json" do
      DawnPatrol::Association.current = @default_association
      event = Events::Create.new.do_it!
      get :index, params: { event_id: event.id }, format: :json
    end
  end
end
