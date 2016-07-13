class Events::Event < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"

  validates :name, presence: true
  validates :starts_at, presence: true

  def location
    [ city, state ].join(", ")
  end
end
