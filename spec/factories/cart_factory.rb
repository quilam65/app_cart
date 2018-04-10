FactoryBot.define do
  factory :cart do
    total_amount_cents 100
    status true
    phone 91919
    name 'name'
    address '195 dien bien phu'
    finished false
    user_id { create(:user).id }
    created_at Time.now
  end
end
