require 'rails_helper'

RSpec.describe VenuesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(:get => '/venues').to route_to('venues#index')
    end

    it 'routes to #show' do
      expect(:get => '/venues/1').to route_to('venues#show', id: '1')
    end
  end
end
