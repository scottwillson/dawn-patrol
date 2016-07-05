class Events::Event < ApplicationRecord
  def location
    [ city, state ].join(", ")
  end
end
