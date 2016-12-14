class Membership < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :person

  validates :person, presence: true

  def current?
    Time.current.between?(start_at, end_at)
  end
end
