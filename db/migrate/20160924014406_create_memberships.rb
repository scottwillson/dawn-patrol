class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :person

      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
