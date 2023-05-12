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
      end
    end
  end
end
