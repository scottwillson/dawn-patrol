require "rails_helper"

RSpec.describe Events::ResultsController, type: :controller do
  before(:each) do
    @default_association = DawnPatrol::Association.create!
  end

  describe "#index" do
    it "responds with html" do
      ActsAsTenant.current_tenant = @default_association
      event = Events::Event.create!
      get :index, params: { event_id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it "responds with json" do
      ActsAsTenant.current_tenant = @default_association
      event = Events::Event.create!
      get :index, params: { event_id: event.id }, format: :json
    end
  end
end
