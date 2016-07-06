class Events::Event < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"

  def location
    [ city, state ].join(", ")
  end
end
