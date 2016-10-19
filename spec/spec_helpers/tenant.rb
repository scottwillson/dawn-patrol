module SpecHelpers
  module Tenant
    def set_current_association_to_default
      DawnPatrol::Association.current = DawnPatrol::Association.new
    end

    def save_default_current_association!
      DawnPatrol::Association.current.save!
    end

    def reset_current_association_to_nil
      DawnPatrol::Association.current = nil
    end
  end
end
