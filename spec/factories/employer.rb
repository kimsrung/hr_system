FactoryBot.define do
  factory :employer do
    sequence(:name) { |n| "eliot#{n}" }
    sequence(:email) { |n| "eliot#{n}@knit.com" }
    password "eloit123"
    association :company
  end
end
