module Events
  class Create
    def initialize(attributes = {})
      @attributes = attributes
    end

    def do_it!
      @attributes[:starts_at] ||= Time.current.in_time_zone(ActsAsTenant.current_tenant.time_zone).beginning_of_day
      Event.create! @attributes
    end
  end
end
