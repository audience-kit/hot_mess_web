require 'rails_helper'

RSpec.describe "venues/edit", :type => :view do
  before(:each) do
    @venue = assign(:venue, Venue.create!(
      :name => "MyString",
      :address => "MyString",
      :phone_number => "MyString"
    ))
  end

  it "renders the edit venue form" do
    render

    assert_select "form[action=?][method=?]", venue_path(@venue), "post" do

      assert_select "input#venue_name[name=?]", "venue[name]"

      assert_select "input#venue_address[name=?]", "venue[address]"

      assert_select "input#venue_phone_number[name=?]", "venue[phone_number]"
    end
  end
end
