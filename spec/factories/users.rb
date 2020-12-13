FactoryBot.define do
  factory :user do
    nickname              { 'sample' }
    email                 { 'sample@sin.cos' }
    password              { 'aaa111' }
    password_confirmation { password }
    birth_date            { 20_000_101 }
    authority             { true }
  end
end
