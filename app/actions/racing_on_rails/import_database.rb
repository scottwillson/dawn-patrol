module RacingOnRails
  class ImportDatabase
    KEYS = %w{ city date discipline id name state }
    COPIED_ATTRIBUTE_KEYS = %w{ city discipline name state }

    def initialize(attributes = {})
      @association = attributes[:association]
      raise(ArgumentError, "association must be present") unless @association.present?
    end

    def do_it!
      RacingOnRails::Event.association = @association
      ActsAsTenant.with_tenant(association_instance) do
        RacingOnRails::Event.transaction do
          RacingOnRails::Event.select(*KEYS).find_each do |racing_on_rails_event|
            Events::Event.create!(event_attributes(racing_on_rails_event))
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
      attributes = racing_on_rails_event.attributes.slice(*COPIED_ATTRIBUTE_KEYS)
      attributes[:starts_at] = racing_on_rails_event.date.beginning_of_day
      attributes[:racing_on_rails_id] = racing_on_rails_event.id
      attributes
    end
  end
end
