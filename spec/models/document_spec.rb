require 'rails_helper'

RSpec.describe Document, type: :model do
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:employee) }
  it { is_expected.to belong_to(:employer) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:employer) }
  it { is_expected.to validate_presence_of(:employee) }
end