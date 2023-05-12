class AddPlayerNameAndPositionUniqueIdxToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_index :players, %i[name position], unique: true
  end
end
