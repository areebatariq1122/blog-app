FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name } 
    body  { Faker::Lorem.paragraph }
    status {"public"}

    association :article
  end
end
