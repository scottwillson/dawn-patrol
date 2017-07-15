class Event < ApplicationRecord
  extend FriendlyId

  acts_as_tenant :dawn_patrol_association
  friendly_id :name_and_year, use: :scoped, scope: :dawn_patrol_association_id

  belongs_to :calculation, class_name: "Calculations::Calculation", optional: true
  has_many :children, class_name: "::Event", foreign_key: :parent_id, inverse_of: :parent
  has_many :event_categories
  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :discipline
  belongs_to :parent, class_name: "::Event", inverse_of: :children, optional: true
  has_many :promoters, class_name: "Promoter"
  has_many :rejections, class_name: "Calculations::Rejection"

  validate :unique_calculated_event
  validates :name, presence: true
  validates :starts_at, presence: true

  scope :calculated, -> { where(calculation_id: true) }
  scope :current_year, -> { where(starts_at: DawnPatrol::Association.current.year_range) }
  scope :year, ->(year) { where(starts_at: DawnPatrol::Association.current.year_range(year)) }

  def self.years
    Event.pluck("distinct date_part('year', starts_at)")
  end

  def calculated?
    calculation_id.present?
  end

  def location
    [ city, state ].join(", ")
  end

  def name_and_year
    "#{name}-#{year}"
  end

  def promoter=(promoter)
    self.promoters.clear

    case promoter
    when Promoter
      self.promoters << promoter
    when Person
      self.promoters << Promoter.new(person: promoter)
    when NilClass
      # OK, just remove all promoters
    else
      raise ArgumentError, "promoter must be Promoter, Person or nil, but was #{promoter.class}"
    end
  end

  def promoter_names
    promoters.map(&:person).map(&:name)
  end

  def unique_calculated_event
    if calculation && calculation.events.year(starts_at.year).where.not(id: id).exists?
      errors.add(:calculation, "already has calculated event for #{starts_at.year}")
    end
  end

  def year
    DawnPatrol::Association.current.year(starts_at)
  end
end
