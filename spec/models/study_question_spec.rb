require 'rails_helper'

RSpec.describe StudyQuestion, type: :model do
  let(:study_question) { create :study_question }
  describe 'relations' do
    it { is_expected.to belong_to(:study).inverse_of(:questions) }
    it { is_expected.to belong_to :question }
    it { is_expected.to have_many :comments }
    it { is_expected.to belong_to(:question_version) }
  end

  describe 'extensions' do
    it { is_expected.to delegate_method(:body).to :question }
    it { is_expected.to delegate_method(:notes).to :question }
  end

  describe '.question' do
    subject { study_question.question }
    context 'when associated question exist' do
      it { is_expected.to be_a Question }
    end
    context 'when associated with version', versioning: true do
      let(:question) { study_question.question }
      before(:each) do
        question.destroy
        study_question.reload
      end
      it { is_expected.to be_a Question }
      it { is_expected.to be_new_record }
    end
  end
end
