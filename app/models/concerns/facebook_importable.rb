module Concerns::FacebookImportable
  extend ActiveSupport::Concern
  
  included do
    
  end
  
  def assign_facebook_attributes(attributes)
  end
  
  module ClassMethods
    def facebook_field_mapping(mapping)
      @@facebook_mapping = mapping
    end
  end
end