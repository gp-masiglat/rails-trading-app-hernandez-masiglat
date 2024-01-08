require 'rails_helper'

RSpec.describe "transactions/edit", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      user_id: 1,
      transaction_type: "MyString",
      stock_name: "MyString",
      number_of_stock: 1,
      total_price: "9.99",
      status: "MyString"
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input[name=?]", "transaction[user_id]"

      assert_select "input[name=?]", "transaction[transaction_type]"

      assert_select "input[name=?]", "transaction[stock_name]"

      assert_select "input[name=?]", "transaction[number_of_stock]"

      assert_select "input[name=?]", "transaction[total_price]"

      assert_select "input[name=?]", "transaction[status]"
    end
  end
end
