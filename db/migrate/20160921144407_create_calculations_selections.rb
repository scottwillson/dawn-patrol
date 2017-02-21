class CreateCalculationsSelections < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations_selections do |t|
      t.belongs_to :calculated_result, null: false
      t.belongs_to :dawn_patrol_association, null: false
      t.float :points, null: false, default: 0
      t.belongs_to :source_result, null: false

      t.index [ :calculated_result_id, :source_result_id ], unique: true, name: :index_calculations_selections_calculated_result_source_result

      t.timestamps
    end
  end
end
