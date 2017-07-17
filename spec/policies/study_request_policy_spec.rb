require 'rails_helper'

RSpec.describe StudyRequestPolicy do
  let(:user) { create :user }
  let(:study_request) { create :study_request, user: user }
  let(:study_creator) { study_request.study.user }
  let(:visitor) { create :user }
  subject { described_class }

  permissions '.scope' do
    let(:scope) { StudyRequest.all }
    subject(:policy_scope) { StudyPolicy::Scope.new(user, scope).resolve }
    it 'includes requests sent' do
      expect(policy_scope).to eq [study_request]
    end
  end

  permissions :show? do
    it { is_expected.to permit user, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end

  permissions :create? do
    it { is_expected.to permit user, study_request }
  end

  permissions :update? do
    it { is_expected.to permit user, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end

  permissions :destroy? do
    it { is_expected.not_to permit user, study_request }
    it { is_expected.not_to permit visitor, study_request }
  end
end
