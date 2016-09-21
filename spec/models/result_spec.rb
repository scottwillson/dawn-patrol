require "rails_helper"

RSpec.describe Result, type: :model do
  it "has person" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    Result.create! person: Person.create!
  end
end
