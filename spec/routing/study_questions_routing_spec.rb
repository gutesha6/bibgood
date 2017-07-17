require 'rails_helper'

RSpec.describe StudyQuestionsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/study_questions/1')
        .to route_to 'study_questions#show', id: '1'
    end
  end
end
