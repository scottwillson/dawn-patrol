class Person < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  has_many :memberships
  has_many :results

  def member?
    memberships.any?(&:current?)
  end
end
