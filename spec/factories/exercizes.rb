FactoryGirl.define do
  factory :exercize do
    lesson
    body { Faker::Lorem.sentence }
    notes { Faker::Lorem.sentence }
    difficulty 1
    factory :admin_exercize, class: Admin::Exercize
  end
end
