class Events::Event < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :discipline
  has_many :promoters

  validates :name, presence: true
  validates :starts_at, presence: true

  scope :calculated, -> { where(calculated: true) }
  scope :year, ->(year) { where(starts_at: Time.zone.local(year).beginning_of_year..Time.zone.local(year).end_of_year) }

  default_value_for :starts_at do
    Time.current.beginning_of_day
  end

  default_value_for :discipline do
    Discipline.where(name: "Road").first_or_create
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
