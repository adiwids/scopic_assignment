module Api
  class PlayerJsonPresenter
    attr_reader :player

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
      @player_skill_data ||= player.player_skills.map do |player_skill|
        Api::PlayerSkillJsonPresenter.new(player_skill).to_h
      end
    end
  end
end
