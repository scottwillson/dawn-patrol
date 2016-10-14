class RacingOnRails::Race < ApplicationRecord
  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]

    belongs_to :category
    belongs_to :event
  end
end
