FactoryBot.define do
  factory :shop do
    name           { 'sample' }
    postal_code    { '334-5545' }
    address        { 'sample' }
    phone_number   { '09034532345' }
    text           { 'sample' }
    after(:build) do |shop|
      shop.image.attach(io: File.open('app/assets/images/3.png'), filename: '3.png')
    end
  end
end
