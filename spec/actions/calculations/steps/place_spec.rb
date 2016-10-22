require "rails_helper"

RSpec.describe "Calculations::Steps::Place" do
  describe ".do_step" do
    it "sets place" do
      results = Calculations::Steps::Place.do_step([ ::Result.new ], {})
      expect(results.first.place).to eq("1")
    end
  end
end
