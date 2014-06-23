# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    first_name "MyString"
    last_name "MyString"
    date_of_birth "2014-06-23"
    phone "MyString"
    email "MyString"
  end
end
