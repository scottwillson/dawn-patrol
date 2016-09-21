class Calculations::Calculation < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  has_many :events, class_name: "Events::Event"
end
