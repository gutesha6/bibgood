require 'rails_helper'

RSpec.describe StudyPolicy do
  let(:user) { create :user }
  let(:study) { create :study, user: user }
  let(:study_user) { create :study_user, study: study }
  let(:participant) { study_user.user }
  let(:visitor) { create :user }

  subject { described_class }

  permissions '.scope' do
    let(:scope) { Study.all }
    subject(:policy_scope) { StudyPolicy::Scope.new(user, scope).resolve }
    it 'shows studies where user is participating' do
      expect(policy_scope).to eq [study]
    end
    context 'when not participating in study' do
      let(:user) { visitor }
      it 'exclude studies where user is not participating' do
        expect(policy_scope).to eq []
      end
    end
  end

  permissions :show? do
    it { is_expected.to permit visitor, study }
  end

  permissions :create? do
    let(:study) { build :study, user: user }
    it { is_expected.to permit user, study }
    it { is_expected.not_to permit nil, study }
    context 'when participate in other lesson study' do
      context 'in pending' do
        before { create :study, lesson: study.lesson, user: user }
        it { is_expected.not_to permit user, study }
      end
      context 'in started' do
        before { create :study, :started, lesson: study.lesson, user: user }
        it { is_expected.not_to permit user, study }
      end
      context 'in completed' do
        before { create :study, :completed, lesson: study.lesson, user: user }
        it { is_expected.to permit user, study }
      end
    end
    context 'when requested study for lesson' do
      let(:concurrent_study) { create :study, lesson: study.lesson }
      let!(:study_request) do
        create :study_request, study: concurrent_study, user: user
      end
      context 'when request is pending' do
        it { is_expected.not_to permit user, study }
      end
      context 'when request is declined' do
        before { study_request.declined! }
        it { is_expected.to permit user, study }
      end
      context 'when request is accepted' do
        before { study_request.accepted! }
        it { is_expected.not_to permit user, study }
      end
    end
  end

  permissions :update? do
    it { is_expected.to permit user, study }
    it { is_expected.not_to permit participant, study }
  end

  permissions :destroy? do
    it { is_expected.to permit user, study }
    it { is_expected.not_to permit participant, study }
  end
end
