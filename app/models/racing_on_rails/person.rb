class RacingOnRails::Person < RacingOnRails::ApplicationRecord
  def self.scrubbed_name(value)
    value&.gsub("\u0000", "")&.gsub("\u0019", "'")
  end

  def name=(value)
    @name = self.scrubbed_name(value)
  end
end
