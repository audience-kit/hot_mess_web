class Address
  include Mongoid::Document

  field :address_line, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: Integer
end