module Concerns::FacebookPrincipal
  extend ActiveSupport::Concern
  include Concerns::FacebookImportable
  
  included do
    field :facebook_access_token,   type: String
    field :facebook_expires_in,     type: Integer
    field :facebook_expires_at,     type: DateTime
  end
  
  def update_facebook_access_token
    new_token = Facebook.oauth.exchange_access_token_info facebook_access_token
    if new_token['access_token']
      self.facebook_access_token = new_token['access_token']
      self.facebook_expires_at = DateTime.getutc.advance seconds: new_token['expires'].to_i
    end
  end
  
  def update_from_facebook(me_graph = facebook_me_graph)
    self.assign_facebook_attributes me_graph
  end
  
  def facebook_me_graph
    facebook_graph.get_object('me').with_indifferent_access
  end

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(self.facebook_access_token) if self.facebook_access_token
    
    @facebook_graph || Facebook.application_graph
  end
  
  
  module ClassMethods
    def find_by_facebook_token(token)
      token = Facebook.oauth.exchange_access_token_info(token)
      graph_api = Koala::Facebook::API.new(token['access_token'])
      me = graph_api.get_object('me')
    
      person = Person.find_or_initialize_by facebook_id: me['id'].to_i
    
      person.user.facebook_access_token = token['access_token']
      person.user.facebook_expires_in = token['expires'].to_i
    
      person.assign_facebook_attributes me

      person.save
      person.user.save
    
      person.user
    end
  end
end