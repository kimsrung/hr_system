require 'rails_helper'

RSpec.describe Company, type: :model do
  it { is_expected.to have_many(:employers) }
  it { is_expected.to have_many(:employees) }
  it { is_expected.to have_many(:documents) }
end