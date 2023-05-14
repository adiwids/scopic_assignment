class Player < ApplicationRecord
  POSITIONS = {
    defender: 'defender',
    midfielder: 'midfielder',
    forward: 'forward'
  }.freeze

  has_many :player_skills, dependent: :destroy
  accepts_nested_attributes_for :player_skills, allow_destroy: true

  validates :name, presence: { message: 'Invalid empty value for name' },
                   uniqueness: {
                    scope: :position,
                    case_sensitive: false,
                    message: -> (object, data) do
                      "has been used for position: #{object.position}"
                    end
                  }

  validates :position, presence: { message: 'Invalid empty value for position' },
                       inclusion: { in: POSITIONS.values, message: 'Invalid value for position: %{value}' }
end
