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
        let(:skill) { player.player_skills.first }

        it 'updates skill and value' do
          new_skill_name = PlayerSkill.skills.values.reject { |sname| sname.eql?(skill.skill) }.sample
          new_skill_value = rand(0..99)

          player.update(player_skills_attributes: [id: skill.id, skill: new_skill_name, value: new_skill_value])

          skill.reload
          expect(skill.skill).to eql(new_skill_name)
          expect(skill.value).to eql(new_skill_value)
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
