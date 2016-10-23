namespace :events do
  desc "Text summary of calculated results to verify calculation code changes. Required: ASSOCIATION. Optional: YEAR."
  task calculated: :environment do
    year = ENV["YEAR"]&.to_i || Time.current.year

    association = ENV["ASSOCIATION"]
    raise("ASSOCIATION is required") unless association
    DawnPatrol::Association.current = DawnPatrol::Association.where(acronym: association).first!

    events = Event.calculated.year(year).includes(categories: { category: :results }).all.order(:starts_at, :name)

    events.each do |event|
      event.races.categories(&:name).each do |event_category|
        puts "#{event.full_name} #{event_category.name} #{event_category.results.count}"
      end
    end

    events.each do |event|
      event.event_categories.sort_by(&:name).each do |event_category|
        puts "#{event.full_name} #{event_category.name} #{event_category.results.sum(:points)}"
      end
    end
  end
end
