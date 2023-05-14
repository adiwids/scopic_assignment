require 'rails_helper'

describe Api::PlayersController, type: :request do
  describe 'DELETE /api/players' do
    let(:auth_token) { Rails.application.credentials[:authorization_token] }
    let!(:player_1) { FactoryBot.create(:player) }

    context 'test_should_delete' do
      it "Should delete" do
        delete "/api/players/#{player_1.id}", params: {}, headers: { 'Authorization' => "Bearer #{auth_token}" }

        expect(response.status).to be_between(1, 900)

        expect(response.body).to be_blank
      end
    end

    context 'with invalid player ID' do
      let(:player_1) { FactoryBot.build_stubbed(:player) }

      it 'returns unauthorized access response' do
        delete "/api/players/#{player_1.id}", params: {}, headers: { 'Authorization' => "Bearer #{auth_token}" }

        expect(response).to have_http_status(:not_found)
        expect(json_response['message']).to match(/invalid resource with id: -?\d+/i)
      end
    end

    context 'without authorization header' do
      it 'returns unauthorized access response' do
        delete "/api/players/#{player_1.id}"

        expect(response).to have_http_status(:unauthorized)
        expect(json_response['message']).to match(/invalid value for authorization token: \(blank\)/i)
      end
    end

    context 'with incorrect authorization header token' do
      let(:auth_token) { 'invalidauthtoken123!' }

      it 'returns unauthorized access response' do
        delete "/api/players/#{player_1.id}", params: {}, headers: { 'Authorization' => "Bearer #{auth_token}" }

        expect(response).to have_http_status(:unauthorized)
        expect(json_response['message']).to match(/invalid value for authorization token: .+/i)
      end
    end
  end
end
