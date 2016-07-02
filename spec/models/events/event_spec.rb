require 'rails_helper'

RSpec.describe Events::Event, type: :model do
  it "creates blank Event" do
    Events::Event.create!
  end
end
