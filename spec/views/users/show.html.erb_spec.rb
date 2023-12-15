require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      username: "Username",
      email_address: "Email Address",
      password_digest: "Password Digest",
      full_name: "Full Name",
      role: "Role",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Email Address/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Role/)
    expect(rendered).to match(/Status/)
  end
end
