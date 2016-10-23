class CreatePromoters < ActiveRecord::Migration[5.0]
  def change
    create_table :promoters do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :event, null: false
      t.belongs_to :person, null: false

      t.index [ :event_id, :person_id ], unique: true

      t.timestamps
    end
  end
end
