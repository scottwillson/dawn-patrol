module Calculations
  class Calculate
    def initialize(attributes = {})
      @calculation = attributes[:calculation]
    end

    def do_it!
      event = @calculation.events.create!(name: @calculation.name)
      category = event.categories.create!(category: Category.create!(name: @calculation.name))

      Result.all.each do |result|
        Calculations::Selection.create!(
          calculated_result: category.results.create!(points: 1),
          points: 1,
          source_result: result
        )
      end

      true
    end
  end
end
