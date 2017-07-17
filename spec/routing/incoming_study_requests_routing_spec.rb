require 'rails_helper'

RSpec.describe IncomingStudyRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/incoming_study_requests')
        .to route_to('incoming_study_requests#index')
    end

    it 'routes to #show' do
      expect(get: '/incoming_study_requests/1')
        .to route_to('incoming_study_requests#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/incoming_study_requests/1/edit')
        .to route_to('incoming_study_requests#edit', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/incoming_study_requests/1')
        .to route_to('incoming_study_requests#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/incoming_study_requests/1')
        .to route_to('incoming_study_requests#update', id: '1')
    end
  end
end
