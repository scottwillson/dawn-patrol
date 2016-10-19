require "rails_helper"

RSpec.describe "Categories::Create" do
  before(:each) do
    save_default_current_association!
  end

  it "creates a new category" do
    category = Categories::Create.new(name: "Women 4/5").do_it!
    expect(category.name).to eq("Women 4/5")
  end

  it "reues existing category" do
    category = Categories::Create.new(name: "Women 4/5").do_it!
    category_2 = Categories::Create.new(name: "Women 4/5").do_it!

    expect(category.name).to eq("Women 4/5")
    expect(category_2.name).to eq("Women 4/5")

    expect(category.id).to eq(category_2.id)
  end
end
