20.times do
  Events::Event.create!(
    datetime: 1.month.from_now,
    discipline: "Road",
    location: "Portland",
    name: "Copperopolis Road Race",
    promoter_name: "Jeff Mitchem",
    phone: "(503) 555-1212"
  )
end
