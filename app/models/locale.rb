class Locale
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :dns_name, type: String

  validates_presence_of :name
  validates_presence_of :dns_name
  validates_format_of :dns_name, with: /\A(?![0-9]+$)(?!-)[a-zA-Z0-9-]{,63}(?<!-)\z/

end