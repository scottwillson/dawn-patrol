association = DawnPatrol::Association.first_or_create!

ActsAsTenant.with_tenant(association) do
  Events::Event.transaction do
    city = Faker::Address.city
    event = Events::Create.new.do_it!(
      starts_at: 1.month.from_now,
      city: city,
      name: "#{city} Road Race",
      promoter: Events::Promoter.new(person: Person.create!(name: "Jeff Mitchem")),
      phone: "(503) 555-1212"
    )

    [ "Category 1/2", "Category 3", "Category 4", "Women 1/2/3", "Women 4" ].each do |category_name|
      category = Category.create!(name: category_name)
      event_category = event.categories.create!(category: category)

      results_count = (rand * 20 + 3).to_i
      (1..results_count).each do |place|
        person = Person.create!(name: Faker::Name.name)
        event_category.results.create!(place: place, person: person)
      end
    end
  end
end
