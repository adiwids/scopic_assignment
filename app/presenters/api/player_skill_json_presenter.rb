module Api
  class PlayerSkillJsonPresenter
    attr_reader :player_skill

    def self.collection(player_skills)
      player_skills.map { |player_skill| new(player_skill).to_h }
    end

    def initialize(player_skill)
      @player_skill = player_skill
    end

    def to_h
      {
        id: player_skill.id,
        skill: player_skill.skill,
        value: player_skill.value,
        player_id: player_skill.player_id
      }
    end
  end
end
