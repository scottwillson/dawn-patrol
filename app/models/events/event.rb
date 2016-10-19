class Events::Event < ApplicationRecord
  acts_as_tenant :dawn_patrol_association

  belongs_to :calculation, class_name: "Calculations::Calculation"
  has_many :categories, class_name: "::Events::Category"
  has_many :children, class_name: "::Events::Event", foreign_key: :parent_id, inverse_of: :parent
  belongs_to :dawn_patrol_association, class_name: "DawnPatrol::Association"
  belongs_to :discipline
  belongs_to :parent, class_name: "::Events::Event", inverse_of: :children
  has_many :promoters

  validates :name, presence: true
  validates :starts_at, presence: true

  scope :calculated, -> { where(calculation_id: true) }
  scope :current_year, -> { where(starts_at: ActsAsTenant.current_tenant.beginning_of_year..ActsAsTenant.current_tenant.end_of_year) }
  scope :year, ->(year) { where(starts_at: ActsAsTenant.current_tenant.beginning_of_year(year)..ActsAsTenant.current_tenant.end_of_year(year)) }

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

    case promoter
    when Events::Promoter
      self.promoters << promoter
    when Person
      self.promoters << Events::Promoter.new(person: promoter)
    when NilClass
      # OK, just remove all promoters
    else
      raise IllegalArgumentError, "promoter must be Promoter, Person or nil, but was #{promoter.class}"
    end
  end

  def promoter_names
    promoters.map(&:person).map(&:name)
  end
end
