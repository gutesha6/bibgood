require 'rails_helper'

RSpec.describe Admin::ExercizesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/lessons/1/exercizes')
        .to route_to('admin/exercizes#index', lesson_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/admin/lessons/1/exercizes/new')
        .to route_to('admin/exercizes#new', lesson_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/admin/exercizes/1')
        .to route_to('admin/exercizes#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/exercizes/1/edit')
        .to route_to('admin/exercizes#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/lessons/1/exercizes')
        .to route_to('admin/exercizes#create', lesson_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/exercizes/1')
        .to route_to('admin/exercizes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/exercizes/1')
        .to route_to('admin/exercizes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/exercizes/1')
        .to route_to('admin/exercizes#destroy', id: '1')
    end
  end
end
