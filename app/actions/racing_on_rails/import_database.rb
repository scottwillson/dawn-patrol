module RacingOnRails
  class ImportDatabase
    COPIED_ATTRIBUTE_KEYS = %w{ city discipline name state }

    def initialize(attributes = {})
      @association = attributes[:association]
      raise(ArgumentError, "association must be present") unless @association.present?
    end

    def do_it!
      RacingOnRails::Event.association = @association
      Events::Event.transaction do
        ActsAsTenant.without_tenant do
          RacingOnRails::Event.select("city", "date", "discipline", "name", "id", "people.name as promoter_name", "state").left_outer_joins(:promoter).find_each do |racing_on_rails_event|
            ActsAsTenant.with_tenant(association_instance) do
              Events::Event.create!(event_attributes(racing_on_rails_event))
            end
          end
        end
      end
    end

    def association_instance
      RacingOnRails::RacingAssociation.association = @association
      racing_on_rails_racing_association = RacingOnRails::RacingAssociation.first
      DawnPatrol::Association.where(
        acronym: racing_on_rails_racing_association.short_name,
        name: racing_on_rails_racing_association.name
      ).first_or_create!
    end

    def event_attributes(racing_on_rails_event)
      attributes = racing_on_rails_event.attributes .slice(*COPIED_ATTRIBUTE_KEYS)

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
  end
end
