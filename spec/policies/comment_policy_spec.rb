require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user) { create :user }
  let(:comment) { create :comment, user: user }

  subject { described_class }

  permissions '.scope' do
    let(:scope) { Comment.all }
    subject(:policy_scope) { StudyPolicy::Scope.new(user, scope).resolve }
    it 'includes all comments received' do
      expect(policy_scope).to eq [comment]
    end
  end

  permissions :create? do
    context 'when commenting study' do
      shared_examples 'study comments' do
        context 'when not study participant' do
          let(:visitor) { create :user }
          it 'should not permit when not study participant' do
            is_expected.not_to permit visitor, comment
          end
        end
      end
      context 'when study question' do
        let(:comment) { build :comment, :for_study_question, user: user }
        include_examples 'study comments'
        context 'when study is not started' do
          it 'should not permit till study is not started' do
            study = create :study, :with_questions
            study.participants << user
            comment = study.questions.first.comments.build
            is_expected.not_to permit user, comment
          end
        end
        context 'when study started' do
          context 'as study participant' do
            context 'when study is started' do
              it { is_expected.to permit user, comment }
            end
          end
        end
      end
      context 'when study exercize' do
        let(:comment) { build :comment, :for_study_exercize, user: user }
        include_examples 'study comments'
        context 'when study is not started' do
          it 'should not permit till study is not started' do
            study = create :study, :with_exercizes
            study.participants << user
            comment = study.exercizes.first.comments.build
            is_expected.not_to permit user, comment
          end
        end
        context 'when study started' do
          context 'as study participant' do
            context 'when exercize is started' do
              before(:each) do
                StudyUserExercize.create!(
                  study_exercize: comment.study.exercizes.first,
                  study_user: comment.user.study_user(comment.study)
                )
              end
              it { is_expected.to permit user, comment }
            end
            context 'when exercize is not started' do
              it { is_expected.not_to permit user, comment }
            end
          end
        end
      end
    end
  end
end
