require 'rails_helper'

RSpec.describe "stocks/edit", type: :view do
  before(:each) do
    @stock = assign(:stock, Stock.create!(
      user_id: 1,
      stock_name: "MyString",
      price: "9.99",
      quantity: 1
    ))
  end

  it "renders the edit stock form" do
    render

    assert_select "form[action=?][method=?]", stock_path(@stock), "post" do

      assert_select "input[name=?]", "stock[user_id]"

      assert_select "input[name=?]", "stock[stock_name]"

      assert_select "input[name=?]", "stock[price]"

      assert_select "input[name=?]", "stock[quantity]"
    end
  end
end
