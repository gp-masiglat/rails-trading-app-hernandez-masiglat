require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        username: "Username",
        email_address: "Email Address",
        password_digest: "Password Digest",
        full_name: "Full Name",
        role: "Role",
        status: "Status"
      ),
      User.create!(
        username: "Username",
        email_address: "Email Address",
        password_digest: "Password Digest",
        full_name: "Full Name",
        role: "Role",
        status: "Status"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "Username".to_s, count: 2
    assert_select "tr>td", text: "Email Address".to_s, count: 2
    assert_select "tr>td", text: "Password Digest".to_s, count: 2
    assert_select "tr>td", text: "Full Name".to_s, count: 2
    assert_select "tr>td", text: "Role".to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
  end
end
