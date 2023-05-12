FactoryBot.define do
  factory :player do
    name      { Faker::Name.name }
    position  { %w(defender midfielder forward).sample } # refers to Player.positions enum
  end
end
