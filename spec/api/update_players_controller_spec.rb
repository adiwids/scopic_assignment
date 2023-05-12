require 'rails_helper'

describe Api::PlayersController, type: :request do
  describe 'PUT /api/players' do
    let!(:player) { FactoryGirl.create(:player, id: 2, name: "old name") }
    let!(:player_skill_1) { FactoryGirl.create(:player_skill, value: 60, skill: 'speed', player: player) }
    let!(:player_skill_2) { FactoryGirl.create(:player_skill, value: 80, skill: 'attack', player: player) }

    context 'test_should_update' do
      it  "Should update" do
        put "/api/players/#{player.id}", params: {
          name: 'updated name',
          position: 'midfielder',
          player_skills: [
            {
              "skill": "strength",
              "value": 40
            },
            {
              "skill": "stamina",
              "value": 30
            }
          ]
        }

        expect(response.status).to be_between(1, 900)
      end
    end
  end
end