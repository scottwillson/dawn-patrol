require "rails_helper"

RSpec.describe "Categories::Create" do
  it "creates a new category" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!

    category = Categories::Create.new(name: "Women 4/5").do_it!

    expect(category.name).to eq("Women 4/5")
  end

  it "reues existing category" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!

    category = Categories::Create.new(name: "Women 4/5").do_it!
    category_2 = Categories::Create.new(name: "Women 4/5").do_it!

    expect(category.name).to eq("Women 4/5")
    expect(category_2.name).to eq("Women 4/5")

    expect(category.id).to eq(category_2.id)
  end
end
