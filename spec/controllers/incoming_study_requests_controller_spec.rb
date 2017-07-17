require 'rails_helper'

RSpec.describe IncomingStudyRequestsController, type: :controller do
  let!(:study_request) { create :incoming_study_request }
  let(:user) { study_request.study.user }
  let(:valid_session) { {} }
  before(:each) { sign_in user }
  describe 'GET #index' do
    let!(:study_request) { create :incoming_study_request }
    it 'assigns all incoming_study_requests as @incoming_study_requests' do
      get :index
      expect(assigns(:incoming_study_requests)).to eq([study_request])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested incoming_study_request as @incoming_study_request' do
      get :show, params: { id: study_request.to_param }
      expect(assigns(:incoming_study_request)).to eq(study_request)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested incoming_study_request as @incoming_study_request' do
      get :edit, params: { id: study_request.to_param }
      expect(assigns(:incoming_study_request)).to eq(study_request)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { status: :accepted, response: 'Kind today' }
      end
      subject(:req) do
        put :update, params: { id: study_request.to_param,
                               incoming_study_request: new_attributes }
      end

      it 'updates the requested incoming_study_request' do
        req
        study_request.reload
        expect(study_request.accepted?).to be_truthy
        expect(study_request.response).to eq new_attributes[:response]
      end

      it 'assigns the requested incoming_study_request as @incoming_study_request' do
        req
        expect(assigns(:incoming_study_request)).to eq(study_request)
      end

      it 'redirects to the incoming_study_request' do
        req
        expect(response).to redirect_to(study_request)
      end
    end
  end
end
