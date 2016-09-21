class Calculations::Selection < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :calculated_result, class_name: "Result"
  belongs_to :source_result, class_name: "Result"

  validates_uniqueness_of :calculated_result, scope: :source_result
end
