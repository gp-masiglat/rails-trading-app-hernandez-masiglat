require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        user_id: 2,
        transaction_type: "Transaction Type",
        stock_name: "Stock Name",
        number_of_stock: 3,
        total_price: "9.99",
        status: "Status"
      ),
      Transaction.create!(
        user_id: 2,
        transaction_type: "Transaction Type",
        stock_name: "Stock Name",
        number_of_stock: 3,
        total_price: "9.99",
        status: "Status"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Transaction Type".to_s, count: 2
    assert_select "tr>td", text: "Stock Name".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
  end
end
