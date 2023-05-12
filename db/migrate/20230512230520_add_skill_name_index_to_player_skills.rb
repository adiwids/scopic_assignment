class AddSkillNameIndexToPlayerSkills < ActiveRecord::Migration[7.0]
  def change
    add_index :player_skills, :skill
  end
end
