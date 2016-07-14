class DawnPatrol::Association < ApplicationRecord
  validates :acronym, presence: true, uniqueness: true
  validates :host, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  def self.table_name_prefix
    'dawn_patrol_'
  end
end
