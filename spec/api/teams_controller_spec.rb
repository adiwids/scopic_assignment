describe Api::TeamsController, type: :request do
  describe 'POST /api/teams' do
    context 'test_should_select_team' do
      let!(:player_1) { FactoryBot.create(:player, position: 'defender') }
      let!(:player_skill_1_1) { FactoryBot.create(:player_skill, value: 80, skill: 'defense', player: player_1) }

      it "Should select team" do
        post '/api/team/process', params: { '_json' => [
          {
            "position": "defender",
            "main_skill": "speed",
            "number_of_players": 2
          }
        ]}

        expect(response.status).to be_between(1, 900)
      end
    end
  end
end
