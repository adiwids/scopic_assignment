require 'rails_helper'

RSpec.describe Api::PlayersController, type: :request do
  describe 'GET /api/players/:id' do
    let(:subject) { get "/api/players/#{player.id}" }

    before { subject }

    context 'player found' do
      let(:player) { FactoryBot.create(:player, randomize_skill_sets: true) }

      it 'returns player details JSON' do
        expect(response).to have_http_status(:ok)

        data = json_response
        expect(data.keys).to match_array(%w(id name position player_skills))
        skill_data = data['player_skills'].first
        expect(skill_data.keys).to match_array(%w(id skill value player_id))
      end
    end

    context 'player not found' do
      let(:player) { double('Player', id: -1) }

      it 'returns not found response' do
        expect(response).to have_http_status(:not_found)
        expect(json_response['message']).to match(/invalid value for ID: [-\d+]/i)
      end
    end
  end
end
