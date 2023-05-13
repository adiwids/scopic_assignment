require 'rails_helper'

RSpec.describe Api::PlayerJsonPresenter do
  describe '.to_h' do
    let(:subject) { described_class.new(player).to_h }

    context 'with skills' do
      let(:player) { FactoryBot.create(:player, :tough_defender) }

      it 'returns player and skills hash' do
        expect(subject.keys).to match_array(%i[id name position player_skills])
        expect(subject[:id]).to eql(player.id)
        expect(subject[:name]).to eql(player.name)
        expect(subject[:position]).to eql(player.position)
        expect(subject[:player_skills].size).to eql(player.player_skills.size)
      end
    end

    # TODO: remove this test examples below when minimum skill validation applied
    context 'without skills' do
      let(:player) { FactoryBot.create(:player) }

      it { expect(subject.keys).to match_array(%i[id name position]) }
    end
  end
end
