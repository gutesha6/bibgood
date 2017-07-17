require 'rails_helper'

RSpec.describe Study, type: :model do
  let(:study) { create :study }
  describe 'relations' do
    it { is_expected.to belong_to :lesson }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:transitions).class_name('StudyTransition') }
    it { is_expected.to have_many(:study_users).dependent(:destroy) }
    it do
      is_expected.to have_many(:questions).class_name('StudyQuestion')
        .inverse_of(:study).dependent(:destroy)
    end
    it do
      is_expected.to have_many(:exercizes).class_name('StudyExercize')
        .inverse_of(:study).dependent(:destroy)
    end
    it do
      is_expected.to have_many(:requests).class_name('StudyRequest')
                                         .dependent(:destroy)
    end
    it do
      is_expected.to have_many(:participants)
        .through(:study_users).class_name('User')
    end
  end

  describe 'callbacks' do
    it { is_expected.to callback(:create_mentor_participant).after(:create) }
    it { is_expected.to callback(:create_questions).after(:create) }
    it { is_expected.to callback(:create_exercizes).after(:create) }
  end

  describe 'validations' do
    it { expect(create(:study).token).not_to be_empty }
    it do
      is_expected.to validate_inclusion_of(:state)
        .in_array(%w[completed]).allow_nil
    end
  end

  describe 'states' do
    let(:study) { create :study }
    it 'should be in pending state' do
      expect(study.in_state?(:pending)).to be_truthy
    end
    context 'when pending' do
      it 'should be started when enough users' do
        while study.participants.count < Study::MIN_USERS
          study.participants << create(:user)
        end
        expect(study.in_state?(:started)).to be_truthy
      end
    end
    context 'when started' do
      let(:study) { create :study, :with_exercizes, :started }
      it 'should be completed when users complete exercizes' do
        study.study_users.each do |study_user|
          exercize = study_user.study_user_exercizes
                               .create(study_exercize: study.exercizes.first)
          exercize.transition_to! :completed
        end
        expect(study.in_state?(:completed)).to be_truthy
      end
    end
  end

  describe '.colearners' do
    let(:user) { study.user }
    context 'when no participants found' do
      it 'returns empty array' do
        expect(study.colearners(user)).to eq []
      end
    end
    context 'when other participants exist' do
      before :each do
        study.participants << create(:user)
      end
      let(:participant) { study.participants.last }
      it 'returns array with user' do
        expect(study.colearners(user)).to eq [participant]
      end
    end
  end

  describe '.participant?' do
    subject { study.participant? user }
    context 'when  user participant' do
      let(:user) { create :user }
      before(:each) { study.participants << user }
      it { is_expected.to be_truthy }
    end
    context 'when creator' do
      let(:user) { study.user }
      it { is_expected.to be_truthy }
    end
    context 'when visitor' do
      let(:user) { create :user }
      it { is_expected.to be_falsey }
    end
  end

  describe '.create_questions' do
    let!(:lesson) { create :lesson, :with_questions }
    it 'creates StudyQuestion' do
      expect { create :study, lesson: lesson }.to change(StudyQuestion, :count).by 1
    end
  end

  describe '.create_exercizes' do
    let!(:lesson) { create :lesson, :with_exercizes }
    it 'creates StudyExercize' do
      expect { create :study, lesson: lesson }.to change(StudyExercize, :count).by 1
    end
  end
end
