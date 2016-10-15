class RacingOnRails::Result < ApplicationRecord
  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]

    belongs_to :race
  end
end