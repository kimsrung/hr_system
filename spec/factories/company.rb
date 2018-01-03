FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Knit#{n}" }
    description  "HR Services"
  end
end
