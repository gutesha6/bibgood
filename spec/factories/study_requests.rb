FactoryGirl.define do
  factory :study_request do
    user
    study
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    factory :incoming_study_request, class: 'IncomingStudyRequest'
  end
end
