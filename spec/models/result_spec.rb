require "rails_helper"

RSpec.describe Result, type: :model do
  before(:each) do
    save_default_current_association!
  end

  it "has person" do
    Events::Create.new.do_it!.categories.create!(category: Category.create!).results.create! person: Person.create!
  end

  describe "#event" do
    it "returns the owning event" do
      event = Events::Create.new.do_it!
      result = event.categories.create!(category: Category.create!).results.create!
      expect(result.event).to eq(event)
    end
  end

  describe ".current_year" do
    it "only finds results from current year" do
      category = Category.create!
      Events::Create.new(starts_at: 1.year.ago.end_of_year).do_it!.categories.create!(category: category).results.create!
      Events::Create.new(starts_at: 1.year.from_now.end_of_year).do_it!.categories.create!(category: category).results.create!
      result = Events::Create.new(starts_at: Time.current).do_it!.categories.create!(category: category).results.create!
      expect(Result.current_year).to eq([ result ])
    end
  end

  describe ".dnf?" do
    it "checks for 'DNF'" do
      expect(Result.new(place: "DNF").dnf?).to be(true)
      expect(Result.new(place: "dnf").dnf?).to be(true)
      expect(Result.new(place: "DQ").dnf?).to be(false)
      expect(Result.new(place: "1").dnf?).to be(false)
      expect(Result.new(place: "99").dnf?).to be(false)
    end
  end

  describe ".placed?" do
    it "numeral or DNF" do
      expect(Result.new(place: "DNF").placed?).to be(true)
      expect(Result.new(place: "DQ").placed?).to be(false)
      expect(Result.new(place: "DNS").placed?).to be(false)
      expect(Result.new(place: "").placed?).to be(false)
      expect(Result.new(place: "1").placed?).to be(true)
      expect(Result.new(place: "99").placed?).to be(true)
    end
  end

  describe ".numeric_place" do
    it "gives non-numeric places a high numeric value" do
      expect(Result.new(place: "1").numeric_place).to eq(1)
      expect(Result.new(place: "99").numeric_place).to eq(99)
      expect(Result.new(place: "DNF").numeric_place).to eq(999_999_999_999)
      expect(Result.new(place: "DQ").numeric_place).to eq(999_999_999_999)
    end
  end
end
