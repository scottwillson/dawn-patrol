require "rails_helper"

RSpec.describe "Calculations::Steps::SelectParticipants" do
  describe ".do_step" do
    it "only selects results with participants" do
      result_without_participant = ::Result.new
      result_with_participant = ::Result.new(person_id: 0)

      source_results = [
        result_without_participant,
        result_with_participant
      ]

      results = Calculations::Steps::SelectParticipants.do_step(source_results, {})

      expect(results).to eq([ result_with_participant ])
    end
  end
end
