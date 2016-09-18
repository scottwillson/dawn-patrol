class RacingOnRails::Event < ApplicationRecord
  belongs_to :promoter, class_name: "Person"

  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]
  end

  def discipline
    self[:discipline] || "Road"
  end
end
