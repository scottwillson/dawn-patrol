class Calculations::Rejection < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :event, class_name: "Events::Event"
  belongs_to :result

  validates_uniqueness_to_tenant :result, scope: :event, message: "Duplicate rejection for this result and calculation event"
end
