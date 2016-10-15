require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe ".title" do
    it "defaults to association acronym" do
      assign(:association, DawnPatrol::Association.new)
      expect(helper.title).to eq("CBRA")
    end
  end
end
