require "rails_helper"

RSpec.describe "Calculations::Steps::RejectDnfs" do
  describe ".do_step" do
    it "rejects DNFs" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.new
      calculation = Calculations::Calculation.new
      results = Calculations::Steps::RejectDnfs.do_step([ Result.new(place: "DNF") ], calculation)
      expect(results).to be_empty
    end

    it "does not reject results with places" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.new
      calculation = Calculations::Calculation.new
      results = Calculations::Steps::RejectDnfs.do_step([ Result.new(place: "1") ], calculation)
      expect(results.size).to eq(1)
    end

    it "does not reject DNFs if Calculation counts DNFs" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.new
      calculation = Calculations::Calculation.new(dnf_points: 1)
      results = Calculations::Steps::RejectDnfs.do_step([ Result.new(place: "DNF") ], calculation)
      expect(results.size).to eq(1)
    end
  end
end
