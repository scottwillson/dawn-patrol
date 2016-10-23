class Promoter < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :event
  belongs_to :person

  validates :event, presence: true
  validates :person, presence: true

  validates_uniqueness_of :event, scope: :person
end