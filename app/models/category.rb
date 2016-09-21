class Category < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  validates_uniqueness_to_tenant :name
  validates :name, presence: true
end
