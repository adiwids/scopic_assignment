FactoryBot.define do
  factory :player do
    name      { Faker::Name.name }
    position  { %w(defender midfielder forward).sample } # refers to Player.positions enum

    transient do
      randomize_skill_sets { false }
    end

    after(:build) do |factory, evaluator|
      if evaluator.randomize_skill_sets
        trait_name = case factory.position
        when 'defender'
          :tough_defender
        when 'midfielder'
          %i[defensive_midfielder attacking_midfielder].sample
        when 'forward'
          %i[attacker target_man].sample
        end

        factory.player_skills_attributes = attributes_for(:player, trait_name)[:player_skills_attributes]
      end
    end

    trait :tough_defender do
      position { 'defender' }

      player_skills_attributes {
        %i[high_defense high_strength medium_stamina medium_speed low_attack].map do |skill_trait|
          FactoryBot.attributes_for(:player_skill, skill_trait).slice(:skill, :value)
        end
      }
    end

    trait :rookie_defender do
      position { 'defender' }

      player_skills_attributes {
        %i[low_defense medium_strength medium_stamina medium_speed low_attack].map do |skill_trait|
          FactoryBot.attributes_for(:player_skill, skill_trait).slice(:skill, :value)
        end
      }
    end

    trait :defensive_midfielder do
      position { 'midfielder' }

      player_skills_attributes {
        %i[high_defense high_strength high_stamina low_speed low_attack].map do |skill_trait|
          FactoryBot.attributes_for(:player_skill, skill_trait).slice(:skill, :value)
        end
      }
    end

    trait :attacking_midfielder do
      position { 'midfielder' }

      player_skills_attributes {
        %i[low_defense medium_strength medium_stamina medium_speed medium_attack].map do |skill_trait|
          FactoryBot.attributes_for(:player_skill, skill_trait).slice(:skill, :value)
        end
      }
    end

    trait :attacker do
      position { 'forward' }

      player_skills_attributes {
        %i[low_defense low_strength medium_stamina medium_speed high_attack].map do |skill_trait|
          FactoryBot.attributes_for(:player_skill, skill_trait).slice(:skill, :value)
        end
      }
    end

    trait :target_man do
      position { 'forward' }

      player_skills_attributes {
        %i[low_defense medium_strength medium_stamina low_speed high_attack].map do |skill_trait|
          FactoryBot.attributes_for(:player_skill, skill_trait).slice(:skill, :value)
        end
      }
    end
  end
end
