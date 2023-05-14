require 'rails_helper'

describe Api::PlayersController, type: :request do
  describe 'POST /api/players' do
    context 'test_should_post' do
      it "Should return post" do
        post '/api/players', params: { '_json' =>
          {
            "name" => "tst",
            "position" => "defender",
            "player_skills" => [
              {
                "skill" => "defense",
                "value" => 10,
              }
            ]
          },
        }

        expect(response.status).to be_between(1, 900)

        data = json_response
        expect(data.keys).to match_array(%w(id name position player_skills))
        skill_data = data['player_skills'].first
        expect(skill_data.keys).to match_array(%w(id skill value player_id))
      end
    end

    context 'with empty player name' do
      let(:params) do
        {
          "_json" => {
            "name" => '',
            "position" => FactoryBot.attributes_for(:player)[:position],
            "player_skills" => [
              {
                "skill" => "defense",
                "value" => 10,
              }
            ]
          }
        }
      end

      it 'returns error response' do
        post '/api/players', params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid empty value for name/i)
      end
    end

    context 'with invalid position' do
      let(:params) do
        {
          "_json" => {
            "name" => FactoryBot.attributes_for(:player)[:name],
            "position" => "#{FactoryBot.attributes_for(:player)[:position]}-ex",
            "player_skills" => [
              {
                "skill" => "defense",
                "value" => 10,
              }
            ]
          }
        }
      end

      it 'returns error response' do
        post '/api/players', params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid value for position: \w+/i)
      end
    end

    context 'with empty position' do
      let(:params) do
        {
          "_json" => {
            "name" => FactoryBot.attributes_for(:player)[:name],
            "position" => '',
            "player_skills" => [
              {
                "skill" => "defense",
                "value" => 10,
              }
            ]
          }
        }
      end

      it 'returns error response' do
        post '/api/players', params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid empty value for position/i)
      end
    end

    context 'with empty skills' do
      let(:params) do
        {
          "_json" => {
            "name" => FactoryBot.attributes_for(:player)[:name],
            "position" => FactoryBot.attributes_for(:player)[:position]
          }
        }
      end

      it 'returns error response' do
        post '/api/players', params: params

        expect(response).to have_http_status(:bad_request)
        expect(json_response['message']).to match(/invalid empty player skills/i)
      end
    end

    context 'with duplicate skills' do
      let(:params) do
        {
          "_json" => {
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
        }
      end

      it 'returns error response' do
        post '/api/players', params: params

        expect(response).to have_http_status(:bad_request)
        expect(json_response['message']).to match(/duplicate value for skill: \w+/i)
      end
    end

    context 'with incorrect skill value' do
      let(:params) do
        {
          "_json" => {
            "name" => FactoryBot.attributes_for(:player)[:name],
            "position" => FactoryBot.attributes_for(:player)[:position],
            "player_skills" => [
              {
                "skill" => "defense",
                "value" => -1,
              }
            ]
          }
        }
      end

      it 'returns error response' do
        post '/api/players', params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['message']).to match(/invalid value for defense: -1/i)
      end
    end

    context 'with incorrect parameter' do
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
        post '/api/players', params: params

        expect(response).to have_http_status(:bad_request)
        expect(json_response['message']).to match(/param is missing .+ _json/i)
      end
    end
  end
end
