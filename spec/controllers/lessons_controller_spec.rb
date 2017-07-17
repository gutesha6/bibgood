require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  describe 'GET #index' do
    let(:req) { get :index }
    let!(:lesson) { create :lesson }

    it 'returns http success' do
      req
      expect(response).to have_http_status(:success)
    end

    it 'assigns lesson as @lesson' do
      req
      expect(assigns(:lessons)).to eq [lesson]
    end
  end
  describe 'GET #show' do
    let!(:lesson) { create :lesson }
    let(:req) { get :show, params: { id: lesson.friendly_id } }
    it 'returns http success' do
      req
      expect(response).to have_http_status(:success)
    end

    it 'assigns lesson as @lesson' do
      req
      expect(assigns(:lesson)).to eq lesson
    end
  end
end
