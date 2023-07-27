FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              { "a1" + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name_em          {Faker::Japanese::Name.last_name}
    first_name_em         {Faker::Japanese::Name.first_name}
    last_name_kana        {last_name_em.yomi}
    first_name_kana       {first_name_em.yomi}
    birth_day             {Faker::Date.birthday(min_age: 6, max_age: 65)}
  end
end