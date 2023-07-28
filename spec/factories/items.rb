FactoryBot.define do
  factory :item do
    title                 {Faker::Name.initials(number: 2)}
    description           {Faker::Lorem.paragraph(sentence_count: 4)}
    category_id           {Faker::Number.between(from: 2, to: 10)}
    condition_id          {Faker::Number.between(from: 2, to: 7)}
    fees_burden_id        {Faker::Number.between(from: 2, to: 3)}
    prefecture_id         {Faker::Number.between(from: 2, to: 48)}
    days_to_ship_id       {Faker::Number.between(from: 2, to: 4)}
    price                 {Faker::Number.between(from: 300, to: 9999999)}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
