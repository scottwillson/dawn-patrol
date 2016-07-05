module RacingOnRails
  class ImportDatabase
    KEYS = %w{ city discipline name state }

    def do_it!
      RacingOnRails::Event.find_each do |racing_on_rails_event|
        attributes = racing_on_rails_event.attributes.slice(*KEYS)
        attributes[:starts_at] = racing_on_rails_event.date.beginning_of_day
        Events::Event.create!(attributes)
      end
    end
  end
end
