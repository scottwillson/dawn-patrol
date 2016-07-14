class Events::Event < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  has_many :promoters

  validates :name, presence: true
  validates :starts_at, presence: true

  default_value_for :starts_at do
    Time.current.beginning_of_day
  end

  def location
    [ city, state ].join(", ")
  end

  def promoter=(promoter)
    self.promoters.clear

    if promoter
      self.promoters << promoter
    end
  end

  def promoter_names
    promoters.map(&:person).map(&:name)
  end
end
