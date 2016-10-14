class RacingOnRails::Category < ApplicationRecord
  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]

    has_many :races
  end
end
