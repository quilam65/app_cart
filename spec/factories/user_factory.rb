FactoryBot.define do
  factory :user do
    email "abc@gmail.com"
    password '123456'
    encrypted_password '123456'
  end
end
