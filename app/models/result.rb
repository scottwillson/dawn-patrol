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
  belongs_to :event_category
  belongs_to :person
end
