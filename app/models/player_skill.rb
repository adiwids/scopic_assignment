class PlayerSkill < ApplicationRecord
  MIN_VALUE = 0
  MAX_VALUE = 99
  SKILL_NAMES = {
    defense: 'defense',
    attack: 'attack',
    speed: 'speed',
    strength: 'strength',
    stamina: 'stamina'
  }.freeze

  belongs_to :player

  validates :skill, presence: { message: 'Invalid empty value for skill' },
                    inclusion: {
                      in: SKILL_NAMES.values,
                      message: ->(object, data) do
                        "Invalid value for #{object.player.position}'s skill: #{data[:value]}"
                      end
                    },
                    uniqueness: {
                      scope: :player_id,
                      message: ->(object, data) do
                        "Duplicate value for #{object.player.position}'s skill: #{data[:value]}"
                      end
                    }

  validates :value, numericality: {
                      only_integer: true,
                      allow_nil: true,
                      greater_than_or_equal_to: MIN_VALUE,
                      less_than_or_equal_to: MAX_VALUE,
                      message: ->(object, data) do
                        "Invalid value for #{object.skill}: #{data[:value]}"
                      end
                    }
end
