class Calculations::Calculation < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  has_and_belongs_to_many :categories
  has_many :events

  def source_event_ids
    @source_event_ids ||= Event.ids
  end
end
