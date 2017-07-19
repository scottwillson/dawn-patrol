class RacingOnRails::ApplicationRecord < ::ApplicationRecord
  self.abstract_class = true

  def self.association=(value)
    establish_connection configurations["racing_on_rails_#{value.downcase}_#{Rails.env}"]
  end
end
