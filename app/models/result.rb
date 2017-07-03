class Result < ApplicationRecord
  # 999_999_999_999, not Float::INFINITY for JSON serialization
  PLACE_MAX = 999_999_999_999

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
  belongs_to :event_category
  belongs_to :person, optional: true

  validates :event_category, presence: true

  scope :current_year, -> do
    joins(event_category: :event).
    where("events.starts_at" => DawnPatrol::Association.current.year_range)
  end

  scope :year, ->(year) do
    joins(event_category: :event).
    where("events.starts_at" => DawnPatrol::Association.current.year_range(year))
  end

  def dnf?
    "DNF".casecmp(place) == 0
  end

  def event
    event_category&.event
  end

  def event_id
    event_category&.event_id
  end

  def member?
    person&.member?
  end

  def name
    person&.name
  end

  def numeric_place
    if place.to_i > 0
      place.to_i
    else
      PLACE_MAX
    end
  end

  def placed?
    place.to_i > 0 || dnf?
  end
end
