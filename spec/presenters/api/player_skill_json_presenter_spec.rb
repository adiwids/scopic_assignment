require 'rails_helper'

RSpec.describe Api::PlayerSkillJsonPresenter do
  let(:player_skill) { FactoryBot.build_stubbed(:player_skill) }

  describe '.to_h' do
    let(:subject) { described_class.new(player_skill).to_h }

    it 'returns player skill hash' do
      expect(subject.keys).to match_array(%i[id skill value player_id])
      expect(subject[:id]).to eql(player_skill.id)
      expect(subject[:skill]).to eql(player_skill.skill)
      expect(subject[:value]).to eql(player_skill.value)
      expect(subject[:player_id]).to eql(player_skill.player_id)
    end
  end
end
