class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.string :name, default: "Road", null: false
      t.index [ :dawn_patrol_association_id, :name ], unique: true
      t.timestamps
    end
  end
end
