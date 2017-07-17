require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  before(:each) { sign_in user }
  describe 'POST #create' do
    context 'when authenticated' do
      shared_examples 'commentable' do
        context 'when participate in study' do
          before(:each) do
            study.participants << user unless study.participant? user
          end
          it 'creates Comment' do
            expect { req }.to change(Comment, :count).by 1
          end

          it 'redirects back to study' do
            req
            expect(response).to redirect_to study_path(study)
          end
        end
      end
      context 'when comment study questions' do
        let(:study) { create :study, :started, :with_questions }
        let(:valid_attributes) { attributes_for(:comment) }
        let(:req) do
          post :create, params: {
            comment: valid_attributes,
            study_question_id: study.questions.first.to_param
          }
        end
        include_examples 'commentable'
      end
      context 'when comment study exercizes' do
        let(:study) { create :study, :started, :with_exercizes }
        let(:valid_attributes) { attributes_for(:comment) }
        let(:req) do
          post :create, params: {
            comment: valid_attributes,
            study_exercize_id: study.exercizes.first.to_param
          }
        end
        before(:each) do
          study.participants << user
          StudyUserExercize.create! study_exercize: study.exercizes.first,
                                    study_user: user.study_user(study)
        end
        include_examples 'commentable'
      end
    end
  end
end
