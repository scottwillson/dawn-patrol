class RacingOnRails::Event < ApplicationRecord
  belongs_to :promoter, class_name: "Person"

  def self.association=(value)
    establish_connection configurations["racing_on_rails"][value.downcase][Rails.env]
  end

  def discipline
    if self[:discipline].present?
      self[:discipline]
    else
      "Road"
    end
  end
end
