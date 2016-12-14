module Memberships
  class New
    def initialize(attributes = {})
      @attributes = attributes
    end

    def do_it!
      @attributes[:end_at] ||= DawnPatrol::Association.current.end_of_year
      @attributes[:start_at] ||= DawnPatrol::Association.current.beginning_of_year
      Membership.new @attributes
    end
  end
end
