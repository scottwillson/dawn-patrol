require "rails_helper"

RSpec.describe EventsController, type: :controller do
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

  describe "#set_current_association_by_host" do
    it "defaults" do
      @request.host = "localhost"
      get :index
      expect(DawnPatrol::Association.current).to eq(@default_association)
    end

    it "sets current_association from request host" do
      atra = DawnPatrol::Association.create!(host: "raceatra.com", acronym: "ATRA", name: "ATRA")

      @request.host = "staging.raceatra.com"
      get :index

      expect(DawnPatrol::Association.current).to eq(atra)
    end

    it "honors X-Forwarded-For" do
      atra = DawnPatrol::Association.create!(host: "raceatra.com", acronym: "ATRA", name: "ATRA")

      @request.host = "0.0.0.0"
      @request.headers["X-Forwarded-For"] = "raceatra.com"
      get :index

      expect(DawnPatrol::Association.current).to eq(atra)
    end

    it "honors position" do
      DawnPatrol::Association.create!(host: "raceatra.com", acronym: "ATRA", name: "ATRA")
      localhost_atra = DawnPatrol::Association.create!(host: "raceatra.com|localhost", acronym: "A2", name: "ATRA 2")
      @default_association.move_to_bottom

      @request.host = "localhost"
      get :index

      expect(DawnPatrol::Association.current).to eq(localhost_atra)
    end

    it "returns 404 for no match" do
      @request.host = "usacycling.org"
      expect { get(:index) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
