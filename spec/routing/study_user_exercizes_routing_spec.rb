require 'rails_helper'

RSpec.describe StudyUserExercizesController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/study_exercizes/1/start')
        .to route_to 'study_user_exercizes#create',
                     study_exercize_id: '1'
    end
  end
end
