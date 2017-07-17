require 'rails_helper'

RSpec.describe StudyUserPolicy do
  let(:user) { create :user }
  let!(:study) { create :study, user: user }
  let(:study_user) { create(:study_user, study: study) }
  let(:participant) { study_user.user }
  subject { described_class }

  permissions '.scope' do
    let(:scope) { StudyUser.all }
    subject(:policy_scope) { StudyUserPolicy::Scope.new(user, scope).resolve }
    context 'when mentor' do
      it { expect(policy_scope).to eq [user.study_user(study)] }
    end

    context 'when participant' do
      it { expect(policy_scope).to eq [user.study_user(study), participant.study_user(study)] }
    end
  end

  permissions :create? do
    it { is_expected.to permit user, study_user }
    it { is_expected.not_to permit participant, study_user }
  end

  permissions :destroy? do
    it { is_expected.to permit user, study_user }
    it { is_expected.not_to permit participant, study_user }
  end
end
