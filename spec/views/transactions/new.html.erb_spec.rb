require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      user_id: 1,
      transaction_type: "MyString",
      stock_name: "MyString",
      number_of_stock: 1,
      total_price: "9.99",
      status: "MyString"
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input[name=?]", "transaction[user_id]"

      assert_select "input[name=?]", "transaction[transaction_type]"

      assert_select "input[name=?]", "transaction[stock_name]"

      assert_select "input[name=?]", "transaction[number_of_stock]"

      assert_select "input[name=?]", "transaction[total_price]"

      assert_select "input[name=?]", "transaction[status]"
    end
  end
end
