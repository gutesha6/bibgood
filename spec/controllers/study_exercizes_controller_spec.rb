require 'rails_helper'

RSpec.describe StudyExercizesController, type: :controller do
  describe 'GET #show' do
    let(:study_exercize) { create :study_exercize }
    it 'returns http success' do
      get :show, params: { id: study_exercize.to_param }
      expect(response).to have_http_status(:success)
    end
  end
end
