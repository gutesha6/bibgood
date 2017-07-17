require 'rails_helper'

RSpec.describe StudyRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/study_requests').to route_to('study_requests#index')
    end

    it 'routes to #new' do
      expect(get: '/studies/1/requests/new')
        .to route_to 'study_requests#new', study_id: '1'
    end

    it 'routes to #show' do
      expect(get: '/study_requests/1')
        .to route_to 'study_requests#show', id: '1'
    end

    it 'routes to #edit' do
      expect(get: '/study_requests/1/edit')
        .to route_to('study_requests#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/studies/1/requests')
        .to route_to('study_requests#create', study_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/study_requests/1')
        .to route_to('study_requests#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/study_requests/1')
        .to route_to('study_requests#update', id: '1')
    end
  end
end
