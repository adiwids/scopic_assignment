module Api
  class PlayerJsonPresenter
    attr_reader :player

    def self.collection(players)
      players.map { |player| new(player).to_h }
    end

    def initialize(player)
      @player = player
    end

    def to_h
      player.player_skills.any? ? base_data.merge(player_skills: player_skill_data) : base_data
    end

    private

    def base_data
      {
        id: player.id,
        name: player.name,
        position: player.position
      }
    end

    def player_skill_data
      @player_skill_data ||= Api::PlayerSkillJsonPresenter.collection(player.player_skills)
    end
  end
end
