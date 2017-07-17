require 'rails_helper'

RSpec.describe StudyUserExercizePolicy do
  subject { described_class }
  permissions :create? do
    let!(:study) do
      create :study, :with_exercizes, exercizes_count: 2
    end
    let(:study_exercize) { study.exercizes.first }
    let(:study_user) { study.study_users.first }
    let(:study_user_exercize) do
      StudyUserExercize.new study_exercize: study_exercize,
                            study_user: study_user
    end
    let(:user) { study_user.user }
    context 'when started other exercize' do
      let!(:alias_study_user_exercize) do
        StudyUserExercize.create study_exercize: study.exercizes.last,
                                 study_user: study_user
      end
      it { is_expected.not_to permit user, study_user_exercize }
    end
    context 'when starting question for other user' do
      let(:user) { create :user }
      it { is_expected.not_to permit user, study_user_exercize }
    end
  end
end
