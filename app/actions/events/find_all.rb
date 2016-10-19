module Events
  class FindAll
    def initialize(attributes = {})
      @year = attributes[:year]
    end

    def do_it!
      Event.includes(promoters: :person).where(starts_at: starts_at_range)
    end

    def starts_at_range
      if @year
        ActsAsTenant.current_tenant.beginning_of_year(@year)..ActsAsTenant.current_tenant.end_of_year(@year)
      else
        ActsAsTenant.current_tenant.beginning_of_year..ActsAsTenant.current_tenant.end_of_year
      end
    end
  end
end
