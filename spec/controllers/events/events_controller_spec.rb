require 'rails_helper'

RSpec.describe Events::EventsController, type: :controller do
  before(:each) do
    DawnPatrol::Association.create!(key: "cbra", name: "Cascadia Bicycle Racing Association")
  end

  describe "#index" do
    it "responds with html" do
      get :index
    end

    it "responds with json" do
      get :index, format: :json
    end
  end
end
