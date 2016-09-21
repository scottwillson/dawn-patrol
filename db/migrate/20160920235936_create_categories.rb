class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.string :name, null: false, default: "New Category"

      t.index [ :dawn_patrol_association_id, :name ], unique: true

      t.timestamps
    end
  end
end
