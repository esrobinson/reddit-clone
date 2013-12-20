# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.sentence
    link_id 1
    parent_id nil
    author_id 1
  end
end
