require 'rails_helper'

RSpec.describe StudyUserExercizesController, type: :controller do
  before(:each) { sign_in user if user }
  describe 'POST #create' do
    let(:study) { create :study, :with_exercizes, :started }
    let(:study_exercize) { study.exercizes.first }
    let(:study_user_id) { user.study_user(study).to_param if user }
    let(:make_request) do
      post :create, params: {
        study_exercize_id: study_exercize.to_param,
        study_user_exercize: { study_user_id: study_user_id }
      }
    end
    include_examples 'authenticated'
    context 'when authenticated' do
      context 'as study user' do
        let(:user) { study.user }
        it 'creates new StudyUserExercize' do
          expect { make_request }.to change(StudyUserExercize, :count).by 1
        end
        it 'should set StudyUserExercize to started state' do
          make_request
          expect(StudyUserExercize.last.current_state).to eq 'started'
        end
      end
    end
  end
end
