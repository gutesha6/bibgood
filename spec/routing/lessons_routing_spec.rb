require 'rails_helper'

describe LessonsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/lessons').to route_to 'lessons#index'
    end

    it 'routes to #show' do
      expect(get: '/lessons/divine').to route_to 'lessons#show', id: 'divine'
    end
  end
end
