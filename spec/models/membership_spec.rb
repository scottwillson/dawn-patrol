require "rails_helper"

RSpec.describe Membership, type: :model do
  it "defaults to this year" do
    DawnPatrol::Association.current = DawnPatrol::Association.create!
    membership = Membership.create!(person: Person.new)
    expect(membership.start_at).to eq(Time.current.beginning_of_year)
    expect(membership.end_at).to eq(Time.current.end_of_year)
  end
end
