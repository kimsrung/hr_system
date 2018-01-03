FactoryBot.define do
  factory :document do
    sequence(:name) { |n| "Contract#{n}" }
    association :company
    association :employee
    association :employer
    assigned_file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'SampleEmploymentContract.pdf'), 'application/pdf') }
  end
end