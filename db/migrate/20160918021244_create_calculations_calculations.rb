class CreateCalculationsCalculations < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations_calculations do |t|
      t.belongs_to :dawn_patrol_association, null: false

      t.decimal :dnf_points, precision: 10, scale: 3, null: false, default: 0
      t.boolean :members_only, default: false, null: false
      t.string :name, null: false, default: "New Calculation"

      t.timestamps
    end
  end
end
