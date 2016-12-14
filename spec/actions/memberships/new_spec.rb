require "rails_helper"

RSpec.describe Memberships::New, type: :model do
  it "defaults to this year" do
    save_default_current_association!
    membership = Memberships::New.new(person: Person.new).do_it!
    expect(membership.start_at).to eq(Time.current.beginning_of_year)
    expect(membership.end_at).to eq(Time.current.end_of_year)
  end
end
