require "rails_helper"

RSpec.describe Calculations::Calculation, type: :model do
  it "can be created" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    Calculations::Calculation.create!
  end

  it "has events" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    calculation = Calculations::Calculation.create!
    event = Events::Create.new.do_it!
    calculation.events << event
    expect(calculation.events.reload).to eq([ event ])
  end
end
