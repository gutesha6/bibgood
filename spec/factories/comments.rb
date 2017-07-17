FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user

    trait :for_study_exercize do
      after :build do |comment|
        study = create :study, :started, user: comment.user
        exercize = create :study_exercize, study: study
        exercize.comments << comment
      end
    end

    trait :for_study_question do
      after :build do |comment|
        study = create :study, :started, user: comment.user
        exercize = create :study_question, study: study
        exercize.comments << comment
      end
    end
  end
end
