require 'rails_helper'

RSpec.describe StudyExercizesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/study_exercizes/1')
        .to route_to 'study_exercizes#show', id: '1'
    end
  end
end
