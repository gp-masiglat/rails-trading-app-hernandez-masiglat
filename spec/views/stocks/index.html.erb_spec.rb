require 'rails_helper'

RSpec.describe "stocks/index", type: :view do
  before(:each) do
    assign(:stocks, [
      Stock.create!(
        user_id: 2,
        stock_name: "Stock Name",
        price: "9.99",
        quantity: 3
      ),
      Stock.create!(
        user_id: 2,
        stock_name: "Stock Name",
        price: "9.99",
        quantity: 3
      )
    ])
  end

  it "renders a list of stocks" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Stock Name".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
