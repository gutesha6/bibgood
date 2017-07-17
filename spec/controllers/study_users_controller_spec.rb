require 'rails_helper'

RSpec.describe StudyUsersController, type: :controller do
  let!(:study) { create :study }
  let(:mentor) { study.study_users.first }
  let(:study_user) { create :study_user, study: study }
  let(:user) { mentor.user }
  before(:each) { sign_in user }
  let(:valid_attributes) { {} }

  shared_examples 'guard study state' do
    it 'redirects to study page' do
      req
      expect(response).to redirect_to study
    end

    it 'sets flash alert message' do
      req
      expect(flash[:alert]).to eq I18n.t('study.state_invalid')
    end
  end

  describe 'GET #index' do
    let(:req) { get :index, params: { study_id: study.to_param } }
    it 'assigns all study_users as @study_users' do
      req
      expect(assigns(:study_users)).to eq([mentor])
    end
  end

  describe 'GET #new' do
    let(:req) { get :new, params: { study_id: study.to_param } }
    it 'assigns a new study_user as @study_user' do
      req
      expect(assigns(:study_user)).to be_a_new(StudyUser)
    end
    context 'when study is started' do
      let(:study) { create :study, :started }
      include_examples 'guard study state'
    end
    context 'when study is completed' do
      let(:study) { create :study, :completed }
      include_examples 'guard study state'
    end
  end

  describe 'POST #create' do
    context 'when study creator' do
      let(:new_user) { create :user }
      let(:valid_attributes) { { user_id: new_user.id } }
      let(:req) do
        post :create, params: { study_user: valid_attributes,
                                study_id: study.id }
      end
      it 'creates a new StudyUser' do
        expect { req }.to change(StudyUser, :count).by(1)
      end
    end
    context 'with valid params' do
      let(:user) { create :user }
      let(:req) do
        post :create, params: { study_user: valid_attributes,
                                study_id: study.id,
                                token: study.token }
      end
      it 'creates a new StudyUser' do
        expect { req }.to change(StudyUser, :count).by(1)
      end

      it 'assigns a newly created study_user as @study_user' do
        req
        expect(assigns(:study_user)).to be_a(StudyUser)
        expect(assigns(:study_user)).to be_persisted
      end

      it 'redirects to the created study_user' do
        req
        expect(response).to redirect_to study_users_path(study)
      end
    end
    context 'with invalid token' do
      let(:user) { create :user }
      let(:req) do
        post :create, params: { study_user: valid_attributes,
                                study_id: study.id,
                                token: 'invalid' }
      end
      it 'redirects to study by default' do
        req
        expect(response).to redirect_to study_path(study)
      end
      it 'sets error flash' do
        req
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:study_user) { create :study_user, study: study }
    let(:req) { delete :destroy, params: { id: study_user.to_param } }
    it 'destroys the requested study_user' do
      expect { req }.to change(StudyUser, :count).by(-1)
    end

    it 'redirects to the study_users list' do
      req
      expect(response).to redirect_to study_users_url(study)
    end
  end
end
