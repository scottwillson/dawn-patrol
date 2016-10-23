require "rails_helper"

RSpec.describe EventCategory, type: :model do
  before(:each) do
    save_default_current_association!
  end

  describe "#name" do
    it "uses category name" do
      event_category = EventCategory.new(category: Category.new(name: "Category 4"))
      expect(event_category.name).to eq("Category 4")
    end
  end

  it "has results" do
    event_category = EventCategory.new
    expect(event_category.results).to be_empty
  end

  it "requires category" do
    event_category = EventCategory.new(event: Events::Event.new)
    expect { event_category.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
