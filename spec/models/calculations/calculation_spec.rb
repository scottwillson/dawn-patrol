require "rails_helper"

RSpec.describe Calculations::Calculation, type: :model do
  before(:each) do
    save_default_current_association!
  end
  
  it "can be created" do
    Calculations::Calculation.create!
  end

  it "has events" do
    calculation = Calculations::Calculation.create!
    event = Events::Create.new.do_it!
    calculation.events << event
    expect(calculation.events.reload).to eq([ event ])
  end
end
