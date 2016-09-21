require "rails_helper"

RSpec.describe Result, type: :model do
  it "has person" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    Events::Event.create!.categories.create!(category: Category.create!).results.create! person: Person.create!
  end

  describe ".current_year" do
    it "only finds results from current year" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      category = Category.create!
      Events::Event.create!(starts_at: 1.year.ago.end_of_year).categories.create!(category: category).results.create!
      Events::Event.create!(starts_at: 1.year.from_now.end_of_year).categories.create!(category: category).results.create!
      result = Events::Event.create!(starts_at: Time.current).categories.create!(category: category).results.create!
      expect(Result.current_year).to eq([ result ])
    end
  end
end
