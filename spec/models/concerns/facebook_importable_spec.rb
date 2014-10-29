require 'rails_helper'

describe Concerns::FacebookImportable do
  before :all do
    ConcernsFacebookImportableOwner = Class.new
    ConcernsFacebookImportableOwner.send :include, Mongoid::Document
    ConcernsFacebookImportableOwner.send :include, Concerns::FacebookImportable
    ConcernsFacebookImportableOwner.has_one :owned, class_name: 'ConcernsFacebookImportableOwned'
    
    ConcernsFacebookImportableOwned = Class.new
    ConcernsFacebookImportableOwned.send :include, Mongoid::Document
    ConcernsFacebookImportableOwned.send :include, Concerns::FacebookImportable
    ConcernsFacebookImportableOwned.belongs_to :owner, class_name: 'ConcernsFacebookImportableOwner'
    ConcernsFacebookImportableOwned.field :facebook_name, type: String
    ConcernsFacebookImportableOwned.facebook_map_attribute :name, :facebook_name
  end
  
  before :each do
    @example_class = Class.new
    @example_class.send :include, Mongoid::Document
    @example_class.send :include, Concerns::FacebookImportable
    
    @example_class.field :facebook_id, type: Integer
    
    @example_class.facebook_map_attributes id: :facebook_id
  end
  
  it "should be creatable" do
    item = @example_class.new
  end
  
  it "should map id to facebook_id when assign_facebook_attributes is called" do
    example_id = 89327432
    facebook_attributes = { id: example_id }
    
    item = @example_class.new
    
    item.assign_facebook_attributes facebook_attributes
    
    expect(item.facebook_id).to eq(example_id)
  end
  
  it "should not map other if it is not a field" do
    facebook_attributes = { other: "Hello" }
    
    item = @example_class.new
    
    expect(item).to receive(:assign_attributes).with({})
    item.assign_facebook_attributes facebook_attributes
  end
  
  it "should not pass attributes to related models that are not initilized" do
    owner = ConcernsFacebookImportableOwner.new
    
    facebook_attributes = { name: "Rick Mark" }
    
    owner.assign_facebook_attributes facebook_attributes
    expect(owner.owned).to be_nil
  end
  
  it "should pass attributes to related models" do
    owner = ConcernsFacebookImportableOwner.new
    owned = owner.build_owned
    
    facebook_attributes = { name: "Rick Mark" }
    
    owner.assign_facebook_attributes facebook_attributes
    expect(owned.facebook_name).to eq(facebook_attributes[:name])
  end
end