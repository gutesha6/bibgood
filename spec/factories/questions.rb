FactoryGirl.define do
  factory :question do
    sequence :position
    body { Faker::Lorem.sentence }
    notes { Faker::Lorem.sentence }
    lesson
    factory :admin_question, class: Admin::Question
  end
end
