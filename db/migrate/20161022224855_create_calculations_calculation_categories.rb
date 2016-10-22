class CreateCalculationsCalculationCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations_calculations_categories, primary_key: false do |t|
      t.belongs_to :calculation
      t.belongs_to :category

      t.timestamps

      t.index [ :calculation_id, :category_id ], name: "index_calculations_categories_on_calculation_id_and_category_id", unique: true
    end
  end
end
