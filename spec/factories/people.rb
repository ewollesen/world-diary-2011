# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "Olivia Newton-John"
    campaign
    description "She's from down-under."

    trait :private do
      private true
    end

    factory :private_person, traits: [:private,]
  end
end
