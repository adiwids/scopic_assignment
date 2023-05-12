class Player < ApplicationRecord
  PLAYER_POSITION
  has_many :player_skills
end
