# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_upload do
      upload "MyString"
      person nil
    end
end