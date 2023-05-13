require 'rails_helper'

RSpec.describe PlayerSkill, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:player) }
  end

  describe '.skill' do
    context 'validation' do
      it { is_expected.to validate_presence_of(:skill) }
      it { is_expected.to allow_value('defense', 'attack', 'speed', 'strength', 'stamina').for(:skill) }
      it { is_expected.to allow_value(:defense, :attack, :speed, :strength, :stamina).for(:skill) }

      context 'with invalid skill names' do
        it 'raises error' do
          ['waiter', 1, :symbol].each do |skill|
            expect { FactoryBot.create(:player_skill, skill: skill) }.to raise_error(ArgumentError)
          end
        end
      end

      context 'duplicate skill for a player' do
        let(:player) { FactoryBot.create(:player) }
        let(:existing_skill) { FactoryBot.create(:player_skill, player: player) }
        let(:new_skill) { FactoryBot.build(:player_skill, player: player, skill: existing_skill.skill) }

        it { expect(new_skill).to be_invalid }
      end
    end
  end

  describe '.value' do
    context 'validation' do
      it { is_expected.to validate_numericality_of(:value).only_integer.allow_nil.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(99) }
      it { is_expected.to allow_value('1', '99').for(:value) }
    end

    context 'with non-numeric values' do
      let(:subject) { FactoryBot.build(:player_skill, value: value).value }

      context 'with string value' do
        let(:value) { 'string' }

        it { expect(subject).to be_zero }
      end

      context 'with symbol value' do
        let(:value) { :symbol }

        it { expect(subject).to be_nil }
      end
    end
  end
end
