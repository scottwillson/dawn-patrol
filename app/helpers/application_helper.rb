module ApplicationHelper
  def default_title
    @association&.acronym
  end

  def title
    default_title
  end
end
