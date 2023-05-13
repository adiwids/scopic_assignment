FactoryBot.define do
  factory :player_skill do
    association :player

    skill { %w(defense attack speed strength stamina).sample } # refers to PlayerSkill.skills enum
    value { rand(0..99) }

    trait :high_valued do
      value { rand(80..99) }
    end

    trait :medium_valued do
      value { rand(51..79) }
    end

    trait :low_valued do
      value { rand(0..50) }
    end

    %w(defense attack speed strength stamina).each do |skill_name|
      trait skill_name.to_sym do
        skill { skill_name }
      end

      # TODO: make dynamic as well
      trait "high_#{skill_name}".to_sym do
        skill { skill_name }
        high_valued
      end

      trait "medium_#{skill_name}".to_sym do
        skill { skill_name }
        medium_valued
      end

      trait "low_#{skill_name}".to_sym do
        skill { skill_name }
        low_valued
      end
    end
  end
end
