# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title Faker::Lorem.sentence
    url Faker::Internet.url
    body Faker::Lorem.paragraph
    poster_id 1
  end
end
