require 'rails_helper'

describe Admin::LessonsController, type: :routing do
  describe 'routing' do
    it 'acts as root' do
      expect(get: '/admin').to route_to 'admin/lessons#index'
    end

    it 'routes to #index' do
      expect(get: 'admin/lessons')
        .to route_to 'admin/lessons#index'
    end

    it 'routes to #new' do
      expect(get: 'admin/lessons/new')
        .to route_to 'admin/lessons#new'
    end

    it 'routes to #edit' do
      expect(get: '/admin/lessons/1/edit')
        .to route_to 'admin/lessons#edit', id: '1'
    end

    it 'routes to #create' do
      expect(post: '/admin/lessons').to route_to 'admin/lessons#create'
    end

    it 'routes to #update' do
      expect(patch: '/admin/lessons/1')
        .to route_to 'admin/lessons#update', id: '1'
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/lessons/1')
        .to route_to 'admin/lessons#destroy', id: '1'
    end
  end
end
