association = DawnPatrol::Association.create!(key: "cbra", name: "Cascadia Bicycle Racing Association")

ActsAsTenant.with_tenant(association) do
  Events::Event.create!(
    starts_at: 1.month.from_now,
    discipline: "Road",
    city: "Portland",
    name: "Copperopolis Road Race",
    promoter_name: "Jeff Mitchem",
    phone: "(503) 555-1212"
  )
end
