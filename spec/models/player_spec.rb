require 'rails_helper'

RSpec.describe Player, type: :model do
  context 'Associations' do
    it { is_expected.to have_many(:player_skills).dependent(:destroy) }
  end

  describe '.name' do
    context 'validation' do
      it { is_expected.to validate_presence_of(:name) }

      context 'with duplicate player name and position' do
        before { @player = FactoryBot.create(:player) }

        it 'should be invalid' do
          expect(described_class.new(name: @player.name, position: @player.position)).to be_invalid
        end
      end
    end
  end

  describe '.position' do
    it { is_expected.to allow_value('defender', 'midfielder', 'forward').for(:position) }
    it { is_expected.to allow_value(:defender, :midfielder, :forward).for(:position) }

    context 'validation' do
      it { is_expected.to validate_presence_of(:position) }

      context 'with invalid position names' do
        it 'raises error' do
          ['other', 1, :symbol].each do |pos|
            expect { FactoryBot.create(:player, position: pos) }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
