class Membership < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :person

  validates :person, presence: true

  default_value_for :start_at, Time.current.beginning_of_year
  default_value_for :end_at, Time.current.end_of_year

  def current?
    Time.current.between?(start_at, end_at)
  end
end
