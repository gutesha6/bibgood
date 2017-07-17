FactoryGirl.define do
  factory :user do
    provider 'facebook'
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    trait :admin do
      admin true
    end
  end
end
