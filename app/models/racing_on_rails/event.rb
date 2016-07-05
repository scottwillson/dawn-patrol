class RacingOnRails::Event < ApplicationRecord
  establish_connection configurations["racing_on_rails"][Rails.env]
end
