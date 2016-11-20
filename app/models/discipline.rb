class Discipline < ApplicationRecord
  extend FriendlyId

  acts_as_tenant :dawn_patrol_association
  friendly_id :name, use: :scoped, scope: :dawn_patrol_association_id

  validates_uniqueness_to_tenant :name
  validates :name, presence: true
end
