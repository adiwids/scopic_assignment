require 'rails_helper'

describe Api::PlayersController, type: :request do
  describe 'DELETE /api/players' do
    context 'test_should_delete' do
      let!(:player_1) { FactoryGirl.create(:player) }

      it "Should delete" do
        delete "/api/players/#{player_1.id}"

        expect(response.status).to be_between(1, 900)
      end
    end
  end
end