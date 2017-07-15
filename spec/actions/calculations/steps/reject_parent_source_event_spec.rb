require "rails_helper"

RSpec.describe "Calculations::Steps::RejectParentSourceEvent" do
  describe ".do_step" do
    it "rejects results from parent events" do
      parent = Result.new(place: "1", event_parent: true)
      child = Result.new(place: "1", event_parent: false)

      results = Calculations::Steps::RejectParentSourceEvent.do_step([ parent, child ], nil)
      expect(results).to eq([ child ])
    end
  end
end
