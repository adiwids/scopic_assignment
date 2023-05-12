class Player < ApplicationRecord
  enum position: {
    defender: 'defender',
    midfielder: 'midfielder',
    forward: 'forward'
  }.freeze

  has_many :player_skills, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { scope: :position, case_sensitive: false }

  validates :position, presence: true
end
