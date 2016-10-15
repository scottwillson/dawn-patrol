class Events::Event < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :calculation
  has_many :categories, class_name: "::Events::Category"
  has_many :children, class_name: "::Events::Event", foreign_key: :parent_id, inverse_of: :parent
  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :discipline
  belongs_to :parent, class_name: "::Events::Event", inverse_of: :children
  has_many :promoters

  validates :name, presence: true
  validates :starts_at, presence: true

  scope :calculated, -> { where(calculation_id: true) }
  scope :current_year, -> { where(starts_at: Time.current.beginning_of_year..Time.current.end_of_year) }
  scope :year, ->(year) { where(starts_at: Time.zone.local(year).beginning_of_year..Time.zone.local(year).end_of_year) }

  default_value_for :starts_at do
    Time.current.beginning_of_day
  end

  default_value_for :discipline do
    Discipline.where(name: "Road").first_or_initialize
  end

  def calculated?
    calculation_id.present?
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
