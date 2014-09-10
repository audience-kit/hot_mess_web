require 'rails_helper'

RSpec.describe "admin/venues/new", :type => :view do
  before(:each) do
    @venue = assign(:venue, Venue.new)
  end

  it "renders new venue form" do
    render

    assert_select "form[action=?][method=?]", admin_venues_path, "post" do

      assert_select "input#venue_name[name=?]", "venue[name]"

      assert_select "input#venue_about[name=?]", "venue[about]"

      assert_select "input#venue_phone[name=?]", "venue[phone]"
    end
  end
end
