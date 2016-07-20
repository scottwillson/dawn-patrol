require "rails_helper"

RSpec.describe "RacingOnRails::ImportDatabaseJob" do
  it "imports Racing on Rails data" do
    expect(DawnPatrol::Association.count).to eq(0)

    RacingOnRails::ImportDatabaseJob.perform_async("ATRA")

    expect(DawnPatrol::Association.count).to eq(1)
  end
end
