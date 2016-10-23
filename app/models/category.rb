class Category < ApplicationRecord
  extend FriendlyId

  acts_as_tenant :dawn_patrol_association
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :calculations

  validates_uniqueness_to_tenant :name
  validates :name, presence: true
end
