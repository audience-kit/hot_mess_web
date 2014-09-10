require 'rails_helper'

RSpec.describe "admin/venues/edit", :type => :view do
  before(:each) do
    @venue = assign(:venue, create(:venue))
  end

  it "renders the edit venue form" do
    render

    assert_select "form[action=?][method=?]", admin_venue_path(@venue), "post" do

      assert_select "input#venue_name[name=?]", "venue[name]"

      assert_select "input#venue_about[name=?]", "venue[about]"

      assert_select "input#venue_phone[name=?]", "venue[phone]"
    end
  end
end
