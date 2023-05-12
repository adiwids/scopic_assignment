class AddPositionIndexToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_index :players, :position
  end
end
