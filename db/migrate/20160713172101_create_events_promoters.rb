class CreateEventsPromoters < ActiveRecord::Migration[5.0]
  def change
    create_table :events_promoters do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :event, null: false
      t.belongs_to :person, null: false

      t.timestamps
    end
  end
end
