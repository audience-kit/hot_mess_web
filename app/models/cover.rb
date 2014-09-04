class Cover
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :source, type: String

end