module Events
  class FindResults
    def initialize(attributes = {})
      @id = attributes[:id]
    end

    def do_it!
      Events::Event.where(id: @id).includes(categories: { results: :person }).includes(categories: :category).first!
    end
  end
end
