require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      username: "MyString",
      email_address: "MyString",
      password_digest: "MyString",
      full_name: "MyString",
      role: "MyString",
      status: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[username]"

      assert_select "input[name=?]", "user[email_address]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[full_name]"

      assert_select "input[name=?]", "user[role]"

      assert_select "input[name=?]", "user[status]"
    end
  end
end
