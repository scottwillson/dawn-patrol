require "rails_helper"

module DawnPatrol
  RSpec.describe "Association" do
    it "can be created" do
      Association.create!(acronym: "mbra", name: "Montana Bicycle Racing Association")
    end
  end
end
