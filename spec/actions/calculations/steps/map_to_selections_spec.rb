require "rails_helper"

RSpec.describe "Calculations::Steps::MapToSelections" do
  describe ".map!" do
    it "maps empty collection" do
      Calculations::Steps::MapToSelections.map!([])
    end

    it "maps results" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      selections = Calculations::Steps::MapToSelections.map!([ Result.new, Result.new ])
      expect(selections.size).to eq(2)
    end
  end
end
