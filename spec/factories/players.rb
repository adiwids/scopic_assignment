FactoryGirl.define do
  factory :player do
    name      { Faker::Name.name }
    position  { [''].sample }
  end
end
