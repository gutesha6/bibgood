require 'rails_helper'

RSpec.describe StudyMailer, type: :mailer do
  describe '#new_comment' do
    let(:comment) { create :comment, :for_study_exercize }
    let(:study) { comment.commentable.study }
    let(:user) { study.participants.first }
    context 'when commenting study question' do
      subject { described_class.new_study_comment(study, comment, user) }
      it { is_expected.to be_truthy }
    end
  end
end
