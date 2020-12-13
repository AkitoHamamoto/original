FactoryBot.define do
  factory :post do
    number    { 2 }
    title     { 'sample' }
    text      { 'sample' }

    after(:build) do |post|
      post.video.attach(io: File.open('app/assets/images/'))
    end
  end
end
