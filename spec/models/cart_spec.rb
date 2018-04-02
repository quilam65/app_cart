require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:orders) }
  it { should have_many(:products) }

end
