class RacingOnRails::RacingAssociation < ApplicationRecord
  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]
  end
end
