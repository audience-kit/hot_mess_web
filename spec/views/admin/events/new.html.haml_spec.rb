require 'rails_helper'

RSpec.describe "admin/events/new", :type => :view do
  before(:each) do
    assign(:event, Event.new(
      :name => "MyString"
    ))

    assign(:importable_events, [])
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", admin_events_path, "post" do

      assert_select "input#event_name[name=?]", "event[name]"
    end
  end
end
