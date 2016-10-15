module RacingOnRails
  class ImportDatabase
    EVENT_ATTRIBUTE_KEYS = %w{ city created_at name state updated_at }.freeze

    def initialize(attributes = {})
      @association = attributes[:association]
      raise(ArgumentError, "association must be present") unless @association.present?
    end

    def do_it!
      RacingOnRails::Category.association = @association
      RacingOnRails::Event.association = @association
      RacingOnRails::Race.association = @association
      RacingOnRails::Result.association = @association

      Events::Event.transaction do
        ActsAsTenant.without_tenant do
          import_events_and_results
          set_parents
        end
      end
    end

    def import_events_and_results
      racing_on_rails_events.find_each do |racing_on_rails_event|
        ActsAsTenant.with_tenant(association_instance) do
          event = Events::Event.create!(event_attributes(racing_on_rails_event))
          racing_on_rails_races(racing_on_rails_event).find_each do |racing_on_rails_race|
            category = Categories::Create.new(name: racing_on_rails_race.attributes["category_name"]).do_it!
            event_category = event.categories.create!(category: category, created_at: racing_on_rails_race.created_at, updated_at: racing_on_rails_race.updated_at)
            racing_on_rails_results(racing_on_rails_race).find_each do |racing_on_rails_result|
              create_result(event_category, racing_on_rails_result)
            end
          end
        end
      end
    end

    def set_parents
      RacingOnRails::Event.select("id", "parent_id").where.not(parent_id: nil).find_each do |racing_on_rails_event|
        ActsAsTenant.with_tenant(association_instance) do
          parent_id = Events::Event.where(racing_on_rails_id: racing_on_rails_event.parent_id).ids.first
          Events::Event.where(racing_on_rails_id: racing_on_rails_event.id).update_all(parent_id: parent_id)
        end
      end
    end

    def association_instance
      RacingOnRails::RacingAssociation.association = @association
      racing_on_rails_racing_association = RacingOnRails::RacingAssociation.first
      DawnPatrol::Association.where(
        acronym: racing_on_rails_racing_association.short_name,
        host: "localhost|0.0.0.0|127.0.0.1|::1|test.host|#{racing_on_rails_racing_association.short_name.downcase}.local",
        name: racing_on_rails_racing_association.name
      ).first_or_create!
    end

    def racing_on_rails_events
      RacingOnRails::Event
        .select("city", "created_at", "date", "discipline", "name", "id", "people.name as promoter_name", "state", "updated_at")
        .left_outer_joins(:promoter)
    end

    def event_attributes(racing_on_rails_event)
      attributes = racing_on_rails_event.attributes.slice(*EVENT_ATTRIBUTE_KEYS)

      attributes[:discipline] = Discipline.where(name: racing_on_rails_event.discipline).first_or_create!
      attributes[:promoter] = promoter(racing_on_rails_event)
      attributes[:racing_on_rails_id] = racing_on_rails_event.id
      attributes[:starts_at] = racing_on_rails_event.date.beginning_of_day

      attributes
    end

    def promoter(racing_on_rails_event)
      if racing_on_rails_event.promoter_name.present?
        person = Person.where(name: racing_on_rails_event.promoter_name).first_or_create!
        Events::Promoter.new(person: person)
      end
    end

    def racing_on_rails_races(event)
      RacingOnRails::Race
        .select("id", "created_at", "categories.name as category_name", "updated_at")
        .left_outer_joins(:category)
        .where(event_id: event.id)
    end

    def racing_on_rails_results(race)
      RacingOnRails::Result
        .select("id", "created_at", "name", "place", "updated_at")
        .where(race_id: race.id)
    end

    def create_result(event_category, result)
      name = result.attributes["name"]
      person = Person.where(name: name).first_or_create!
      attributes = result.attributes.slice(*%w{ created_at place updated_at })
      event_category.results.create!(attributes.merge(person_id: person.id))
    end
  end
end
