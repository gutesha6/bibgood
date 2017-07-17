require 'rails_helper'

RSpec.describe StudiesController, type: :controller do
  let(:user) { create :user }
  let(:lesson) { create :lesson }
  let(:study) { create :study }
  let(:valid_attributes) { attributes_for :study }
  let(:invalid_attributes) { attributes_for :study, lesson: nil }
  before(:each) { sign_in user if user }

  describe 'GET #index' do
    let!(:study) { create :study }
    let(:req) { get :index }
    context 'when requesting all studies' do
      let(:req) { get :index, params: { scope: 'all' } }
      it 'assigns all studies as @studies' do
        req
        expect(assigns(:studies)).to eq([study])
      end

      describe 'use status params' do
        let(:req) { get :index, params: { status: :pending, scope: 'all' } }
        it 'assigns all studies as @studies' do
          req
          expect(assigns(:studies)).to eq([study])
        end
      end
    end

    context 'when not authorized' do
      let(:user) { nil }
      it 'assigns all studies as @studies' do
        req
        expect(assigns(:studies)).to eq([study])
      end
    end
  end

  describe 'GET #show' do
    let!(:study) { create :study }
    it 'assigns the requested study as @study' do
      get :show, params: { id: study.to_param }
      expect(assigns(:study)).to eq(study)
    end
  end

  describe 'GET #edit' do
    let!(:study) { create :study, user: user }
    it 'assigns the requested study as @study' do
      get :edit, params: { id: study.to_param }
      expect(assigns(:study)).to eq(study)
    end
  end

  describe 'POST #create' do
    let(:req) do
      post :create, params: { study: valid_attributes,
                              lesson_id: lesson.to_param }
    end

    context 'with valid params' do
      it 'creates a new Study' do
        expect { req }.to change(Study, :count).by(1)
      end

      it 'assigns a newly created study as @study' do
        req
        expect(assigns(:study)).to be_a(Study)
        expect(assigns(:study)).to be_persisted
      end

      it 'redirects to the page to invite study users' do
        req
        expect(response).to redirect_to new_study_user_path(Study.last)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when completing study' do
      let(:study) { create :study, :started, user: user }
      let(:req) do
        patch :update, params: { study: { state: :completed },
                                 id: study.to_param }
      end

      it 'should be completed' do
        req
        expect(study.current_state).to eq 'completed'
      end
    end
  end
end
