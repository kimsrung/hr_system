FactoryBot.define do
  factory :employee do
    sequence(:name) { |n| "rotana#{n}" }
    sequence(:email) { |n| "rotana#{n}@knit.com" }
    password "rotana123"
    association :company
  end
end
