class AddPositionToAssociation < ActiveRecord::Migration[5.0]
  def change
    add_column :dawn_patrol_associations, :position, :integer
  end
end
