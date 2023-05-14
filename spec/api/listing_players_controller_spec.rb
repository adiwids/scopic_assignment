require 'rails_helper'
describe Api::PlayersController, type: :request do
  describe 'GET /api/players' do
    before do
      @players = FactoryBot.create_list(:player, 10, randomize_skill_sets: true)
    end

    context 'test_should_list' do
      it 'should list' do
        get api_players_path

        expect(response.status).to be_between(1, 900)

        data = json_response
        expect(data).to be_a(Array)
        expect(data.size).to eql(@players.size)
        entry = data.first
        expect(entry.keys).to match_array(%w(id name position player_skills))
        skill_data = entry['player_skills'].first
        expect(skill_data.keys).to match_array(%w(id skill value player_id))
      end
    end
  end
end
