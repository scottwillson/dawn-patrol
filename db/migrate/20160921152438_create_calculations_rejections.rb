class CreateCalculationsRejections < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations_rejections do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :event, null: false
      t.belongs_to :result, null: false

      t.string :reason

      t.index [ :event_id, :result_id ], unique: true

      t.timestamps
    end
  end
end
