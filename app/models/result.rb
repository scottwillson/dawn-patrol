class Result < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  has_many :calculations_selections,
           class_name: "Calculations::Selection",
           foreign_key: :calculated_result_id,
           dependent: :destroy

  has_many :calculations_source_selections,
           class_name: "Calculations::Selection",
           foreign_key: :source_result_id,
           dependent: :destroy

  has_many :calculations_rejections, class_name: "Calculations::Rejection"
  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :event_category, class_name: "Events::Category"
  belongs_to :person

  validates :event_category, presence: true

  scope :current_year, -> do
    joins(event_category: :event).
    where("events_events.starts_at" => Time.current.beginning_of_year..Time.current.end_of_year)
  end

  def dnf?
    "DNF".casecmp(place) == 0
  end

  def event
    event_category&.event
  end

  def member?
    person&.member?
  end

  def placed?
    place.to_i > 0 || dnf?
  end
end
