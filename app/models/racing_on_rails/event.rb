class RacingOnRails::Event < RacingOnRails::ApplicationRecord
  belongs_to :promoter, class_name: "Person", optional: true

  def discipline
    if self[:discipline].present?
      self[:discipline]
    else
      "Road"
    end
  end

  def imported_attributes
    _attributes = attributes.slice(*%w{ city created_at name state updated_at })

    _attributes[:discipline] = Discipline.where(name: discipline).first_or_create!
    _attributes[:promoter] = imported_promoter
    _attributes[:racing_on_rails_id] = id
    _attributes[:starts_at] = date.beginning_of_day

    _attributes
  end

  def imported_promoter
    if promoter_id
      person = ::Person.where(racing_on_rails_id: promoter_id, name: promoter_name).first_or_create!
      Promoter.new(person: person)
    end
  end
end
