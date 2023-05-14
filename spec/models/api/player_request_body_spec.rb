require 'rails_helper'

RSpec.describe Api::PlayerRequestBody do
  let(:player_data) { FactoryBot.attributes_for(:player) }

  describe '.initialize' do
    let(:subject) { described_class.new(attributes) }



    context 'without player skills attributes' do
      let(:attributes) do
        {
          name: player_data[:name],
          position: player_data[:position]
        }
      end

      it { expect {subject}.to raise_error ArgumentError }
    end
  end

  describe '.to_h' do
    let(:subject) { described_class.new(attributes).to_h }

    context 'skills modification' do
      let(:player) { FactoryBot.create(:player, :tough_defender) }

      let(:attributes) do
        {
          id: player.id,
          name: player_data[:name],
          position: player_data[:position],
          player_skills: [
            { skill: 'defense', value: 1 }, # update defense value
            { skill: 'speed', value: nil } # remove speed skill
          ]
        }
      end

      it 'appends ID and destroy keys for existing skills' do
        defense_entry = subject[:player_skills_attributes].detect { |data| data[:skill] == 'defense' }
        speed_entry = subject[:player_skills_attributes].detect { |data| data[:_destroy].present? }

        expect(defense_entry.keys).to include(:id)
        expect(speed_entry).to be_present
      end
    end

    context 'with duplicate skills values' do
      let(:attributes) do
        {
          name: player_data[:name],
          position: player_data[:position],
          player_skills: [
            { skill: 'defense', value: 1 },
            { skill: 'defense', value: 2 }
          ]
        }
      end

      it { expect {subject}.to raise_error ArgumentError }
    end
  end
end
