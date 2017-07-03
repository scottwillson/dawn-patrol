class RacingOnRails::Race < RacingOnRails::ApplicationRecord
  belongs_to :category
  belongs_to :event
end
