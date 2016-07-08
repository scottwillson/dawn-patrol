require 'rails_helper'

RSpec.describe Events::Event, type: :model do
  it "creates blank Event" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    Events::Event.create!
  end
end
