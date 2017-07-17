require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :commentable }
    it { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe '.study_comment?' do
    subject { comment.study_comment? }
    context 'when study exists' do
      let(:comment) { build :comment, :for_study_exercize }
      it { is_expected.to be_truthy }
    end

    context 'when study is not defined' do
      let(:comment) { build :comment }
      it { is_expected.to be_falsey }
    end
  end

  describe '.study' do
    subject { comment.study }
    let(:comment) { build :comment, :for_study_exercize }
    it { is_expected.to be_a Study }
  end

  describe '.send_notifications' do
    context 'when for study exercize' do
      let(:study) { create :study, :started, :with_exercizes }
      it 'notifies study colearners' do
        expect do
          create :comment, commentable: study.exercizes.first,
                           user: study.user
        end.to change(ActionMailer::Base.deliveries, :count)
          .by(study.participants.count - 1)
      end
    end
    context 'when reply to comment' do
      let(:study) { create :study, :started, :with_exercizes }
      let!(:comment) do
        create :comment, commentable: study.exercizes.first,
                         user: study.user
      end
      it 'notifies study colearners' do
        expect do
          create :comment, commentable: comment, user: study.user
        end.to change(ActionMailer::Base.deliveries, :count)
          .by(study.participants.count - 1)
      end
    end
  end
end
