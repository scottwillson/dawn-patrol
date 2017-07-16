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

    it "defaults to current year" do
      current_year = DawnPatrol::Association.current.year
      get :index, format: :json
      expect(assigns(:year)).to eq(current_year)
    end

    it "defaults nil year to current year" do
      current_year = DawnPatrol::Association.current.year

      get :index, format: :json, params: { year: nil }

      expect(assigns(:year)).to eq(current_year)
      json = JSON.parse(response.body)
      link_group = json["link_groups"].detect { |lg| lg["slug"] == "year"}
      expect(link_group["links"]).to eq([ current_year ])
      expect(link_group["selected"]).to eq(current_year)
    end

    it "ensures years is unique" do
      DawnPatrol::Association.current = @default_association
      Events::Create.new(starts_at: Time.zone.local(2012, 5)).do_it!

      get :index, format: :json, params: { year: 2012 }

      expect(assigns(:year)).to eq(2012)
      json = JSON.parse(response.body)
      link_group = json["link_groups"].detect { |lg| lg["slug"] == "year"}
      expect(link_group["links"]).to eq([ 2012 ])
      expect(link_group["selected"]).to eq(2012)
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
