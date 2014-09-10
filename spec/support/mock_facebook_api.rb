
module Mock
  module Facebook
    APP_ACCESS_TOKEN = "app_access_token_for_mocks"

    def self.mock_facebook_api(state)
      # oauth_class_double = class_double("Koala::Facebook::OAuth")
      # oauth_double = instance_double("Koala::Facebook::OAuth")
      # graph_double = class_double("Koala::Facebook::API")
      #
      # expect(oauth_class_double).to receive(:new).and_return(oauth_double)
      # expect(oauth_double).to receive(:get_app_access_token).and_return(Mock::Facebook::APP_ACCESS_TOKEN)
      # expect(graph_double).to receive(:new).with(Mock::Facebook::APP_ACCESS_TOKEN).and_return(Mock::Facebook::API.new)
      state.stub_const("Koala::Facebook::API", Mock::Facebook::API)
    end

    class API
      def initialize(auth_token)
        @auth_token = auth_token
      end

      def get_object(path)
        resposne_path = File.join(RSpec.configuration.fixture_path, "#{path}.json")

        JSON.parse(File.read(resposne_path))['data']
      end
    end
  end
end


