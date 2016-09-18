class AddEventsEventsCalculated < ActiveRecord::Migration[5.0]
  def change
    add_column :events_events, :calculated, :boolean
  end
end
