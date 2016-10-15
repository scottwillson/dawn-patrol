require "rails_helper"

RSpec.describe Events::ResultsHelper, type: :helper do
  describe ".title" do
    it "uses @event" do
      association = DawnPatrol::Association.new
      ActsAsTenant.current_tenant = association
      assign(:association, association)

      assign(:event, Events::Event.new(name: "Carolina State Championship", starts_at: Time.zone.local(2012, 5, 13)))

      expect(helper.title).to eq("CBRA: 2012 Results: Carolina State Championship")
    end
  end
end
