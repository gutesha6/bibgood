require 'rails_helper'

RSpec.describe StudyUsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/studies/1/users')
        .to route_to 'study_users#index', study_id: '1'
    end

    it 'routes to #new' do
      expect(get: '/studies/1/users/new')
        .to route_to 'study_users#new', study_id: '1'
    end

    it 'routes to #create' do
      expect(post: '/studies/1/users')
        .to route_to 'study_users#create', study_id: '1'
    end

    it 'routes to #destroy' do
      expect(delete: '/study_users/1').to route_to('study_users#destroy', id: '1')
    end
  end
end
