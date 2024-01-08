require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      user_id: 2,
      transaction_type: "Transaction Type",
      stock_name: "Stock Name",
      number_of_stock: 3,
      total_price: "9.99",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Transaction Type/)
    expect(rendered).to match(/Stock Name/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
  end
end
