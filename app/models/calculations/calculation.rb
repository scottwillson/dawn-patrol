class Calculations::Calculation < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  has_many :events, class_name: "Events::Event"

  def categories
    @categories ||= [ Category.new(name: name) ]
  end

  def source_events
    Events::Event.all
  end
end
