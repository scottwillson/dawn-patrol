require 'rails_helper'

RSpec.describe Person, type: :model do
  it "creates unamed Person" do
    ActsAsTenant.current_tenant = DawnPatrol::Association.create!
    person = Person.create!
    expect(person.name).to eq(nil)
  end
end
