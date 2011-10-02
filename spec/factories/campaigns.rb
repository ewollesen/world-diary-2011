# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign do
    name "Xanadu"
    dm
    description "The magical world of Xanadu.  Bring your rollerskates."

    trait :private do
      private true
    end

    factory :private_campaign, traits: [:private,]
  end
end
