require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:lesson) { create :lesson }
  let(:user) { create :user }

  describe 'relations' do
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:exercizes) }
    it { is_expected.to have_many(:studies) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
  end

  describe 'callbacks' do
    it 'generates friendly id' do
      lesson = create :lesson
      expect(lesson.slug).not_to be_empty
    end
  end

  describe '.active_study?' do
    subject { lesson.active_study?(user) }
    context 'when user participates' do
      context 'in pending study' do
        before(:each) { create :study, lesson: lesson, user: user }
        it { is_expected.to be_truthy }
      end
      context 'in running study' do
        before(:each) { create :study, :started, lesson: lesson, user: user }
        it { is_expected.to be_truthy }
      end
      context 'in completed study' do
        before(:each) { create :study, :completed, lesson: lesson, user: user }
        it { is_expected.to be_falsey }
      end
    end
    context 'when user not learning lesson' do
      it { is_expected.to be_falsey }
    end
  end

  describe '.study_request?' do
    subject { lesson.study_request? user, :pending }
    let(:study) { create :study, lesson: lesson }
    context 'when study request is not present' do
      it { is_expected.to be_falsey }
    end
    context 'when study request with other status' do
      before do
        create :study_request, study: study, status: 'declined', user: user
      end
      it { is_expected.to be_falsey }
    end
    context 'when study request with requested status' do
      before { create :study_request, study: study, user: user }
      it { is_expected.to be_truthy }
    end
  end
end
