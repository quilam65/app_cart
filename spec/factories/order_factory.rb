FactoryBot.define do
  factory :order do
    quanlity 2
    order 'becarful'
    product_id { create(:product).id }
    cart_id { create(:cart).id }
  end
end
