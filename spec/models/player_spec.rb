require 'rails_helper'

RSpec.describe Player, type: :model do
  context 'Associations' do
    it { is_expected.to have_many(:player_skills).dependent(:destroy) }
  end

  describe '.name' do
    context 'validation' do
      it { is_expected.to validate_presence_of(:name).with_message('Invalid empty value for name') }

      context 'with duplicate player name and position' do
        before { @player = FactoryBot.create(:player) }

        it 'should be invalid' do
          player = FactoryBot.build(:player, name: @player.name, position: @player.position)
          expect(player).to be_invalid
          expect(player.errors.full_messages.first).to match(/name has been used for position: \w+/i)
        end
      end
    end
  end

  describe '.position' do
    it { is_expected.to allow_value('defender', 'midfielder', 'forward').for(:position) }
    it { is_expected.to allow_value(:defender, :midfielder, :forward).for(:position) }

    context 'validation' do
      it { is_expected.to validate_presence_of(:position).with_message('Invalid empty value for position') }

      context 'with invalid position names' do
        it 'should be invalid' do
          ['other', 1, :symbol].each do |pos|
            player = FactoryBot.build(:player, position: pos)
            expect(player).to be_invalid
            expect(player.errors.full_messages.first).to match(/invalid value for position: \w+/i)
          end
        end
      end
    end
  end

  describe '.player_skills' do
    context 'nested attributes' do
      let(:skill_attributes) do
        [
          FactoryBot.attributes_for(:player_skill).slice(:skill, :value),
          FactoryBot.attributes_for(:player_skill).slice(:skill, :value)
        ]
      end

      context 'on build or create' do
        let(:player) { FactoryBot.build(:player, player_skills_attributes: skill_attributes) }
        it { expect(player.player_skills.size).to eql(skill_attributes.size) }
      end

      context 'on skill updates' do
        let(:player) { FactoryBot.create(:player, player_skills_attributes: skill_attributes) }

        it 'updates skill and value' do
          current_skill = player.player_skills.first
          new_skill_name = PlayerSkill::SKILL_NAMES.values.detect { |sname| !sname.eql?(current_skill.skill.to_s) }
          new_skill_value = rand(0..99)

          player.update(player_skills_attributes: [id: current_skill.id, skill: new_skill_name, value: new_skill_value])

          current_skill.reload
          expect(current_skill.skill).to eql(new_skill_name)
          expect(current_skill.value).to eql(new_skill_value)
        end
      end

      context 'on skill removal' do
        let(:player) { FactoryBot.create(:player, player_skills_attributes: skill_attributes) }
        let(:removed_skill) { player.player_skills.sample }
        let(:removal_update) { player.update(player_skills_attributes: [id: removed_skill.id, _destroy: true]) }

        it 'removes skill by ID' do
          expect { removal_update }.to change { player.player_skills.count }.to(skill_attributes.size - 1)
        end
      end
    end
  end
end
