class Events::Category < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :category, class_name: "::Category"
  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :event
  has_many :results, foreign_key: :event_category_id

  validates :category, :event, presence: true

  def name
    category&.name
  end
end
