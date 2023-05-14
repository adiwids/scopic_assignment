require 'rails_helper'

RSpec.describe MostSkilledPlayerQuery do
  before(:all) do
    # position first-to-last: defender -> forward -> midfielder
    # skill first-to-last: attack -> defense -> speed -> stamina -> strengh
    @tough_defender = FactoryBot.create(:player, :tough_defender)
    @rookie_defender = FactoryBot.create(:player, :rookie_defender)
    @attacking_midfielder = FactoryBot.create(:player, :attacking_midfielder)
    @attacker = FactoryBot.create(:player, :attacker)
  end

  describe '.call' do
    let(:subject) { described_class.call(filters) }

    context 'without filters' do
      let(:filters) { {} }

      it 'returns players ordered by position, skill name and then value from the highest to lowest' do
        expect(subject.pluck(:id)).to match([@tough_defender.id, @rookie_defender.id, @attacker.id, @attacking_midfielder.id])
      end
    end

    context 'with filters' do
      context "by player's position" do
        it 'returns players on given position ordered by skill name and value from the highest to lowest'
      end

      context "by skill's name" do
        it 'returns players with given skill name ordered by position and value from the highest to lowest'
      end
    end
  end
end
