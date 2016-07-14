require "rails_helper"


RSpec.describe Events::EventsController, type: :controller do
  before(:each) do
    @default_association = DawnPatrol::Association.create!
  end

  describe "#index" do
    it "responds with html" do
      get :index
    end

    it "responds with json" do
      get :index, format: :json
    end
  end

  describe "#set_current_tenant_by_host" do
    it "defaults" do
      @request.host = "localhost"
      get :index
      expect(ActsAsTenant.current_tenant).to eq(@default_association)
    end

    it "sets current_tenant from request host" do
      atra = DawnPatrol::Association.create!(host: "raceatra.com", acronym: "ATRA", name: "ATRA")

      @request.host = "staging.raceatra.com"
      get :index

      expect(ActsAsTenant.current_tenant).to eq(atra)
    end

    it "honors X-Forwarded-For" do
      atra = DawnPatrol::Association.create!(host: "raceatra.com", acronym: "ATRA", name: "ATRA")

      @request.host = "0.0.0.0"
      @request.headers["X-Forwarded-For"] = "raceatra.com"
      get :index

      expect(ActsAsTenant.current_tenant).to eq(atra)
    end

    it "returns 404 for no match" do
      @request.host = "usacycling.org"
      expect { get(:index) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
