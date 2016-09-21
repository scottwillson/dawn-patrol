require "rails_helper"


RSpec.describe Events::Category, type: :model do
  describe "#name" do
    it "uses category name" do
      ActsAsTenant.current_tenant = DawnPatrol::Association.create!
      event_category = Events::Category.new(category: Category.new(name: "Category 4"))
      expect(event_category.name).to eq("Category 4")
    end
  end

  it "has results" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    event_category = Events::Category.new
    expect(event_category.results).to be_empty
  end
end
