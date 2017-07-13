class Calculations::Calculation < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :excluded_source_events, class_name: "Event"
  has_many :events

  def excluded_source_event_ids
    @excluded_source_event_ids ||= excluded_source_events.ids
  end

  def source_event_ids
    @source_event_ids ||= Event.ids
  end
end
