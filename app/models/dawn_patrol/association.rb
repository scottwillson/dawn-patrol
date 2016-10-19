class DawnPatrol::Association < ApplicationRecord
  validates :acronym, presence: true, uniqueness: true
  validates :host, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  acts_as_list

  def self.table_name_prefix
    'dawn_patrol_'
  end

  def beginning_of_year(year = Time.current.year)
    current_time = Time.zone.local(year || Time.current.year)
    current_time.beginning_of_year.in_time_zone(time_zone)
  end

  def end_of_year(year = Time.current.year)
    current_time = Time.zone.local(year || Time.current.year)
    current_time.end_of_year.in_time_zone(time_zone)
  end
end
