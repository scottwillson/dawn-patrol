class RacingOnRails::EventEditor < ApplicationRecord
  def self.table_name
    "editors_events"
  end

  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]
  end
end
