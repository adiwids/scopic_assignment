require 'rails_helper'

describe Api::PlayersController, type: :request do
  describe 'PUT /api/players' do
    let!(:player) { FactoryBot.create(:player, id: 2, name: "old name") }
    let!(:player_skill_1) { FactoryBot.create(:player_skill, value: 60, skill: 'speed', player: player) }
    let!(:player_skill_2) { FactoryBot.create(:player_skill, value: 80, skill: 'attack', player: player) }

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

        data = json_response
        expect(data.keys).to match_array(%w(id name position player_skills))
        expect(data['player_skills'].size).to eql(4)
        skill_data = data['player_skills'].first
        expect(skill_data.keys).to match_array(%w(id skill value player_id))
      end
    end

    context 'with empty player name' do
      let(:params) do
        {
          name: '',
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
      end

      it 'returns error response' do
        put "/api/players/#{player.id}", params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid value for name: \(blank\)/i)
      end
    end

    context 'with empty position' do
      let(:params) do
        {
          name: FactoryBot.attributes_for(:player)[:name],
          position: '',
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
      end

      it 'returns error response' do
        put "/api/players/#{player.id}", params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid value for position: \(blank\)/i)
      end
    end

    context 'with invalid position' do
      let(:params) do
        {
          name: FactoryBot.attributes_for(:player)[:name],
          position: "#{FactoryBot.attributes_for(:player)[:name]}-ex",
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
      end

      it 'returns error response' do
        put "/api/players/#{player.id}", params: params

        expect(response).to have_http_status(:bad_request)
        expect(json_response['message']).to match(/invalid value for position: \(blank\)/i)
      end
    end

    context 'with empty skills' do
      let(:params) do
        {
          "name" => FactoryBot.attributes_for(:player)[:name],
          "position" => FactoryBot.attributes_for(:player)[:position]
        }
      end

      it 'returns error response' do
        put "/api/players/#{player.id}", params: params

        expect(response).to have_http_status(:bad_request)
        expect(json_response['message']).to match(/invalid value for player skills: \(empty\)/i)
      end
    end

    context 'with duplicate skills' do
      let(:params) do
        {
          "name" => FactoryBot.attributes_for(:player)[:name],
          "position" => FactoryBot.attributes_for(:player)[:position],
          "player_skills" => [
            {
              "skill" => "defense",
              "value" => 10,
            },
            {
              "skill" => "defense",
              "value" => 20,
            }
          ]
        }
      end

      it 'returns error response' do
        put "/api/players/#{player.id}", params: params

        expect(response).to have_http_status(:bad_request)
        expect(json_response['message']).to match(/invalid value for player skills: defense \(duplicate\)/i)
      end
    end

    context 'with incorrect skill value' do
      let(:params) do
        {
          "name" => FactoryBot.attributes_for(:player)[:name],
          "position" => FactoryBot.attributes_for(:player)[:position],
          "player_skills" => [
            {
              "skill" => "defense",
              "value" => -1,
            }
          ]
        }
      end

      it 'returns error response' do
        put "/api/players/#{player.id}", params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid value for defense: -1/i)
      end
    end

    context 'with invalid player ID' do
      let(:params) do
        {
          "name" => FactoryBot.attributes_for(:player)[:name],
          "position" => FactoryBot.attributes_for(:player)[:position],
          "player_skills" => [
            {
              "skill" => "defense",
              "value" => 10,
            }
          ]
        }
      end

      it 'returns error response' do
        put "/api/players/-1", params: params

        expect(response).to have_http_status(:not_found)
        expect(json_response['message']).to match(/invalid value for ID: -1/i)
      end
    end
  end
end
