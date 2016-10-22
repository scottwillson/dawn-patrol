require "rails_helper"

RSpec.describe "Calculations::Steps::Sort" do
  describe ".do_step" do
    it "sorts by points" do
      result_1 = ::Result.new(points: 3)
      result_2 = ::Result.new(points: 5)
      result_3 = ::Result.new(points: 4)
      result_4 = ::Result.new(points: 1)

      results = [ result_1, result_2, result_3, result_4 ]

      sorted_results = Calculations::Steps::Sort.do_step(results, {})

      expect(sorted_results).to eq([ result_2, result_3, result_1, result_4 ])
    end
  end
end
