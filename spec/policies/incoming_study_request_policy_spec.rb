require 'rails_helper'

RSpec.describe IncomingStudyRequestPolicy do
  let(:study_request) { create :study_request }
  let(:user) { study_request.study.user }
  let(:author) { study_request.user }
  let(:visitor) { create :user }

  subject { described_class }

  permissions '.scope' do
    let(:scope) { StudyRequest.all }
    subject(:policy_scope) { StudyPolicy::Scope.new(user, scope).resolve }
    it 'includes study requests received' do
      expect(policy_scope).to eq [study_request]
    end
  end

  permissions :show? do
    it { is_expected.to permit user, study_request }
    it { is_expected.not_to permit author, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end

  permissions :create? do
    it { is_expected.not_to permit user, study_request }
    it { is_expected.not_to permit author, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end

  permissions :update? do
    it { is_expected.to permit user, study_request }
    it { is_expected.not_to permit author, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end

  permissions :destroy? do
    it { is_expected.not_to permit user, study_request }
    it { is_expected.not_to permit author, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end
end
