FactoryBot.define do
  factory :post do
    number    { 2 }
    title     { 'sample' }
    text      { 'sample' }

    association :user

    after(:build) do |post|
      post.video.attach(io: File.open('app/assets/images/1.mp4'), filename: '3.png')
    end
    after(:build) do |post|
      post.image.attach(io: File.open('app/assets/images/1.png'), filename: '1.png')
    end
  end
end
