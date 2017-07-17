FactoryGirl.define do
  factory :lesson do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    factory :admin_lesson, class: Admin::Lesson
    trait :with_video do
      video_id 'aaaaaaa'
    end
    trait :with_questions do
      transient { questions_count 1 }
      after :create do |lesson, evaluator|
        create_list(:question, evaluator.questions_count, lesson: lesson)
      end
    end
    trait :with_exercizes do
      transient { exercizes_count 1 }
      after :create do |lesson, evaluator|
        create_list(:exercize, evaluator.exercizes_count, lesson: lesson)
      end
    end
  end
end
