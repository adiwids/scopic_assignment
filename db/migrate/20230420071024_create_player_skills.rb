class CreatePlayerSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :player_skills do |t|
      t.string :skill
      t.integer :value
      t.belongs_to :player

      t.timestamps
    end
  end
end
