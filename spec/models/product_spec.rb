require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it {should validate_numericality_of(:price).is_greater_than(0) }
end
