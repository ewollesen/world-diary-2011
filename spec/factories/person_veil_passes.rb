# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_veil_pass do
    person
    user
    includes_uploads true
  end
end
