require 'rails_helper'

RSpec.describe "stocks/new", type: :view do
  before(:each) do
    assign(:stock, Stock.new(
      user_id: 1,
      stock_name: "MyString",
      price: "9.99",
      quantity: 1
    ))
  end

  it "renders new stock form" do
    render

    assert_select "form[action=?][method=?]", stocks_path, "post" do

      assert_select "input[name=?]", "stock[user_id]"

      assert_select "input[name=?]", "stock[stock_name]"

      assert_select "input[name=?]", "stock[price]"

      assert_select "input[name=?]", "stock[quantity]"
    end
  end
end
