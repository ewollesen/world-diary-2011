# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Gary Gygax"
    email "gygax@example.com"
    password "password"
    password_confirmation "password"

    factory :dm do
      name "Bruce Cordell"
      email "cordell@example.com"
    end
  end

end
