class CreateCalculationsCalculationsEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :calculations_calculations_events, primary_key: false do |t|
      t.belongs_to :calculation
      t.belongs_to :event

      t.timestamps

      t.index [ :calculation_id, :event_id ], name: "index_calculations_events_on_calculation_id_and_event_id", unique: true      
    end
  end
end
