require 'rails_helper'

RSpec.describe Employer, type: :model do
  it { is_expected.to belong_to(:company) }
  it { is_expected.to have_many(:documents) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
end