require 'rails_helper'

RSpec.describe StudyRequestsController, type: :controller do
  let(:study_request) { create :study_request }
  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :study_request }
  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  before(:each) { sign_in user }

  describe 'GET #index' do
    let!(:study_request) { create :study_request, user: user }
    it 'assigns all study_requests as @study_requests' do
      get :index
      expect(assigns(:study_requests)).to eq([study_request])
    end
    it 'excludes study_requests created by alias user' do
      create :study_request
      get :index
      expect(assigns(:study_requests)).to eq([study_request])
    end
  end

  describe 'GET #show' do
    let!(:study_request) { create :study_request, user: user }
    it 'assigns the requested study_request as @study_request' do
      get :show, params: { id: study_request.to_param }
      expect(assigns(:study_request)).to eq(study_request)
    end
  end

  describe 'GET #new' do
    let!(:study) { create :study }
    it 'assigns a new study_request as @study_request' do
      get :new, params: { study_id: study.to_param }
      expect(assigns(:study_request)).to be_a_new(StudyRequest)
    end
  end

  describe 'GET #edit' do
    let!(:study_request) { create :study_request, user: user }
    it 'assigns the requested study_request as @study_request' do
      get :edit, params: { id: study_request.to_param }
      expect(assigns(:study_request)).to eq(study_request)
    end
  end

  describe 'POST #create' do
    let!(:study) { create :study }
    context 'with valid params' do
      let(:req) do
        post :create, params: { study_request: valid_attributes, study_id: study.id }
      end

      it 'creates a new StudyRequest' do
        expect { req }.to change(StudyRequest, :count).by(1)
      end

      it 'assigns a newly created study_request as @study_request' do
        req
        expect(assigns(:study_request)).to be_a(StudyRequest)
        expect(assigns(:study_request)).to be_persisted
      end

      it 'redirects to the created study_request' do
        req
        expect(response).to redirect_to(StudyRequest.last)
      end
    end
  end

  describe 'PUT #update' do
    let!(:study_request) { create :study_request, user: user }
    context 'with valid params' do
      let(:new_attributes) { valid_attributes }
      let(:req) do
        put :update, params: { id: study_request.to_param,
                               study_request: new_attributes }
      end

      it 'updates the requested study_request' do
        req
        study_request.reload
        expect(study_request.body).to eq new_attributes[:body]
      end

      it 'assigns the requested study_request as @study_request' do
        req
        expect(assigns(:study_request)).to eq(study_request)
      end

      it 'redirects to the study_request' do
        req
        expect(response).to redirect_to(study_request)
      end
    end
  end
end
