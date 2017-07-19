class AddCalculationPoints < ActiveRecord::Migration[5.1]
  def change
    add_column :calculations_calculations, :points, :jsonb, default: []
  end
end
