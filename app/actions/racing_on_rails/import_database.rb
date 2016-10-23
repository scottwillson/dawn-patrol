module RacingOnRails
  class ImportDatabase
    def initialize(attributes = {})
      @association = attributes[:association]
      @time_zone = attributes[:time_zone]
      raise(ArgumentError, "association must be present") unless @association.present?
    end

    def do_it!
      RacingOnRails::Category.association = @association
      RacingOnRails::Event.association = @association
      RacingOnRails::EventEditor.association = @association
      RacingOnRails::Person.association = @association
      RacingOnRails::Race.association = @association
      RacingOnRails::Result.association = @association

      Events::Event.transaction do
        ActsAsTenant.without_tenant do
          import_events_and_results
          import_event_editors
          set_parents
        end
      end
    end

    def import_events_and_results
      racing_on_rails_events.find_each do |racing_on_rails_event|
        ActsAsTenant.with_tenant(association_instance) do
          event = Events::Create.new(racing_on_rails_event.imported_attributes).do_it!
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

    def import_event_editors
      RacingOnRails::EventEditor.select("editor_id", "event_id").each do |editor|
        ActsAsTenant.with_tenant(association_instance) do
          person = ::Person.where(racing_on_rails_id: editor.editor_id).first

          if person.nil?
            racing_on_rails_person = RacingOnRails::Person.find(editor.editor_id)
            person = ::Person.create!(name: racing_on_rails_person.name, racing_on_rails_id: editor.editor_id)
          end

          event = Events::Event.where(racing_on_rails_id: editor.event_id).first!
          Events::Promoter.create!(event: event, person: person)
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
      association = DawnPatrol::Association.where(acronym: racing_on_rails_racing_association.short_name).first_or_create!
      association.update!(
        host: "localhost|0.0.0.0|127.0.0.1|::1|test.host|#{racing_on_rails_racing_association.short_name.downcase}.local",
        name: racing_on_rails_racing_association.name,
        time_zone: @time_zone || "Pacific Time (US & Canada)"
      )
      association
    end

    def racing_on_rails_events
      RacingOnRails::Event
        .select("city", "created_at", "date", "discipline", "name", "id", "promoter_id", "people.name as promoter_name", "state", "updated_at")
        .left_outer_joins(:promoter)
    end

    def racing_on_rails_races(event)
      RacingOnRails::Race
        .select("id", "created_at", "categories.name as category_name", "updated_at")
        .left_outer_joins(:category)
        .where(event_id: event.id)
    end

    def racing_on_rails_results(race)
      RacingOnRails::Result
        .select("id", "created_at", "name", "person_id", "points", "place", "time", "updated_at")
        .where(race_id: race.id)
    end

    def create_result(event_category, result)
      person = nil

      if result.attributes["person_id"]
        name = result.attributes["name"]
        person = ::Person.where(racing_on_rails_id: result.attributes["person_id"], name: name).first_or_create!
      end

      attributes = result.attributes.slice(*%w{ created_at place points time updated_at })
      attributes[:points] = attributes[:points] || 0
      event_category.results.create!(attributes.merge(person_id: person&.id))
    end
  end
end
