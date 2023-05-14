require 'rails_helper'

RSpec.describe PlayerSkill, type: :model do
  let(:subject) { FactoryBot.build(:player_skill) }

  context 'Associations' do
    it { is_expected.to belong_to(:player) }
  end

  describe '.skill' do
    context 'validation' do
      it { is_expected.to validate_presence_of(:skill).with_message("Invalid empty value for skill") }
      it { is_expected.to allow_value('defense', 'attack', 'speed', 'strength', 'stamina').for(:skill) }
      it { is_expected.to allow_value(:defense, :attack, :speed, :strength, :stamina).for(:skill) }

      context 'with invalid skill names' do
        it 'should be invalid' do
          ['waiter', 1, :symbol].each do |skill|
            player_skill = FactoryBot.build(:player_skill, skill: skill)
            expect(player_skill).to be_invalid
            expect(player_skill.errors.full_messages.first).to match(/invalid value for \w+\'s skill: \w+/i)
          end
        end
      end

      context 'duplicate skill for a player' do
        let(:player) { FactoryBot.create(:player) }
        let(:existing_skill) { FactoryBot.create(:player_skill, player: player) }
        let(:new_skill) { FactoryBot.build(:player_skill, player: player, skill: existing_skill.skill) }

        it 'should be invalid' do
          expect(new_skill).to be_invalid
          expect(new_skill.errors.full_messages.first).to match(/duplicate value for \w+\'s skill: \w+/i)
        end
      end
    end
  end

  describe '.value' do
    context 'validation' do
      it { is_expected.to allow_value(nil, '1', '99').for(:value) }

      context 'invalid values' do
        it 'should be invalid' do
          [-1, 100, 1.1].each do |val|
            skill = FactoryBot.build(:player_skill, value: val)
            expect(skill).to be_invalid
            expect(skill.errors.full_messages.first).to match(/invalid value for \w+: -?\d+/i)
          end
        end
      end
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
