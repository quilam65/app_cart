FactoryBot.define do
  factory :product do
    title "product name"
    description 'product description'
    price 10
    image 'https://i.ytimg.com/vi/ktlQrO2Sifg/maxresdefault.jpg'
    category_id { create(:category).id }
  end
end
