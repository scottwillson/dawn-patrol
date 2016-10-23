class CreateEventCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :event_categories do |t|
      t.belongs_to :category
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :event
      t.string :slug, null: false

      t.index [ :event_id, :slug ], unique: true
      t.index [ :category_id, :event_id ]

      t.timestamps
    end
  end
end
