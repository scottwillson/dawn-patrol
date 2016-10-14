module Categories
  class Create
    def initialize(attributes = {})
      @name = attributes[:name]
    end

    def do_it!
      ::Category.where(name: @name).first_or_create!
    end
  end
end
