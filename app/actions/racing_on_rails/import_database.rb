module RacingOnRails
  class ImportDatabase
    KEYS = %w{ city discipline name state }

    def initialize(attributes = {})
      @association = attributes[:association]
      raise(ArgumentError, "association must be present") unless @association.present?
    end

    def do_it!
      RacingOnRails::Event.association = @association
      ActsAsTenant.with_tenant(association_instance) do
        RacingOnRails::Event.transaction do
          RacingOnRails::Event.find_each do |racing_on_rails_event|
            attributes = racing_on_rails_event.attributes.slice(*KEYS)
            attributes[:starts_at] = racing_on_rails_event.date.beginning_of_day
            Events::Event.create!(attributes)
          end
        end
      end
    end

    def association_instance
      RacingOnRails::RacingAssociation.association = @association
      racing_on_rails_racing_association = RacingOnRails::RacingAssociation.first
      DawnPatrol::Association.where(key: @association, name: racing_on_rails_racing_association.name).first_or_create!
    end
  end
end
