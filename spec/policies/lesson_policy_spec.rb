require 'rails_helper'

RSpec.describe LessonPolicy do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:lesson) { create :lesson }

  subject { described_class }

  permissions '.scope' do
    subject(:policy_scope) { LessonPolicy::Scope.new(user, scope).resolve }
    let!(:lesson) { create :lesson }
    let(:scope) { Lesson.all }
    context 'when unauthenticated' do
      let(:user) { nil }
      it 'returns all lessons' do
        expect(policy_scope).to eq [lesson]
      end
    end

    context 'when authenticated' do
      it 'returns all lessons' do
        expect(policy_scope).to eq [lesson]
      end
    end
  end

  permissions :show? do
    it { is_expected.to permit nil, lesson }
    it { is_expected.to permit user, lesson }
  end

  permissions :create? do
  end

  permissions :update? do
  end

  permissions :destroy? do
  end
end
