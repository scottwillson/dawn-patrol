require "rails_helper"

RSpec.describe Events::Category, type: :model do
  before(:each) do
    save_default_current_association!
  end
  
  describe "#name" do
    it "uses category name" do
      event_category = Events::Category.new(category: Category.new(name: "Category 4"))
      expect(event_category.name).to eq("Category 4")
    end
  end

  it "has results" do
    event_category = Events::Category.new
    expect(event_category.results).to be_empty
  end
end
