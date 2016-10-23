class EventCategory < ApplicationRecord
  extend FriendlyId

  acts_as_tenant :dawn_patrol_association
  friendly_id :name, use: :scoped, scope: :event_id

  belongs_to :category
  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :event, class_name: "Events::Event"
  has_many :results

  validates :category, :event, presence: true

  def name
    category&.name
  end
end
