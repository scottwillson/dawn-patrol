module ApplicationHelper
  def title
    @title || @association&.acronym
  end
end
