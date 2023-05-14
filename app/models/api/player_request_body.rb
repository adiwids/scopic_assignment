module Api
  class PlayerRequestBody
    include ActiveModel::Model

    attr_accessor :id, :name, :position, :player_skills

    def initialize(attributes = {})
      super
      raise ArgumentError.new('Invalid value for player skills: (empty)') unless player_skills&.any?
    end

    def to_h
      {
        name: name,
        position: position,
        player_skills_attributes: compose_skill_attributes
      }
    end

    private

    def compose_skill_attributes
      skill_entries = []
      skill_attributes = []
      existing_skills = {}

      existing_skills_ids = PlayerSkill.where(player_id: id).select(:id, :skill).pluck(:skill, :id).to_h if id

      player_skills.each do |params|
        raise ArgumentError.new("Invalid value for player skills: #{params[:skill]} (duplicate)") if skill_entries.include?(params[:skill])

        skill_entries << params[:skill]
        entry = { skill: params[:skill], value: params[:value] }
        entry[:id] = existing_skills_ids[params[:skill]] if existing_skills_ids && existing_skills_ids.key?(params[:skill])
        if entry[:id] && !params[:value]
          entry[:_destroy] = true
          entry.delete(:skill)
          entry.delete(:value)
        end

        skill_attributes << entry
      end

      skill_attributes
    end
  end
end
