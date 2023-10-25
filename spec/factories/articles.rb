FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence } 
    body  { Faker::Lorem.paragraph }
    image { Faker::LoremFlickr.image}
    status {"public"}
  end
end