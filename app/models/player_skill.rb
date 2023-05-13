class PlayerSkill < ApplicationRecord
  MIN_VALUE = 0
  MAX_VALUE = 99

  enum skill: {
    defense: 'defense',
    attack: 'attack',
    speed: 'speed',
    strength: 'strength',
    stamina: 'stamina'
  }.freeze

  belongs_to :player

  validates :skill, presence: true,
                    uniqueness: { scope: :player_id }

  validates :value, numericality: {
                      only_integer: true,
                      allow_nil: true,
                      greater_than_or_equal_to: MIN_VALUE,
                      less_than_or_equal_to: MAX_VALUE
                    }
end
