require 'rails_helper'

RSpec.describe StudyQuestionPolicy do
  let(:study_question) { create :study_question }
  let(:user) { create :user }
  subject { described_class }

  permissions :show? do
    it { is_expected.to be_truthy }
  end
end
