class CreateCalculationsCalculations < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations_calculations do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.string :name, null: false, default: "New Calculation"
      t.timestamps
    end
  end
end
