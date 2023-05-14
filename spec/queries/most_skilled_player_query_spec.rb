require 'rails_helper'

RSpec.describe MostSkilledPlayerQuery do
  before(:all) do
    @tough_defender = FactoryBot.create(:player, :tough_defender)
    @rookie_defender = FactoryBot.create(:player, :rookie_defender)
  end

  describe '.call' do
    let(:subject) { described_class.call(filters) }

    context 'without filters' do
      let(:filters) { {} }

      it 'returns players ordered by position, skill name and then value from the highest to lowest'
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
