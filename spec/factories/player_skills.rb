FactoryBot.define do
  factory :player_skill do
    association :player

    skill { %w(defense attack speed strength stamina).sample } # refers to PlayerSkill.skills enum
    value { rand(0..99) }
  end
end
