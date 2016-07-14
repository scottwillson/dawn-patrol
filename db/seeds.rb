association = DawnPatrol::Association.create!

ActsAsTenant.with_tenant(association) do
  Events::Event.create!(
    starts_at: 1.month.from_now,
    city: "Portland",
    name: "Copperopolis Road Race",
    promoter: Events::Promoter.new(person: Person.create!(name: "Jeff Mitchem")),
    phone: "(503) 555-1212"
  )
end
