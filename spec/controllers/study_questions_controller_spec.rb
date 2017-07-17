require 'rails_helper'

RSpec.describe StudyQuestionsController, type: :controller do
  let(:study_question) { create :study_question }
  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: study_question }
      expect(response).to have_http_status(:success)
    end
  end
end
