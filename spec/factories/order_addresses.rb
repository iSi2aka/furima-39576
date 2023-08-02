FactoryBot.define do
  factory :order_address do
    postal_code           {'123-4567'}
    prefecture_id         {Faker::Number.between(from: 2, to: 48)}
    city                  {Faker::Address.city}
    street_num            {Faker::Address.street_address}
    building_num          {Faker::Address.building_number}
    phone_num             {Faker::PhoneNumber.phone_number.gsub(/\D/, '')[0..10]}
    
  end 
end
