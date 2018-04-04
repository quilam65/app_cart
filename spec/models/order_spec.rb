require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should validate_presence_of(:quanlity) }
  it { should validate_numericality_of(:quanlity).is_greater_than(0)}
  it { should belong_to(:product) }
  it { should belong_to(:cart) }

end
