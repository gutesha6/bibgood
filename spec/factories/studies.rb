FactoryGirl.define do
  factory :study do
    lesson
    user
    trait :with_questions do
      transient { questions_count 1 }
      lesson do
        create :lesson, :with_questions, questions_count: questions_count
      end
    end
    trait :with_exercizes do
      transient { exercizes_count 1 }
      lesson do
        create :lesson, :with_exercizes, exercizes_count: exercizes_count
      end
    end
    trait :started do
      after(:create) do |study|
        create_list :study_user, Study::MIN_USERS - 1, study: study
      end
    end
    trait :completed do
      after(:create) do |study|
        create_list :study_user, Study::MIN_USERS - 1, study: study
        study.transition_to :completed
      end
    end
  end
end
