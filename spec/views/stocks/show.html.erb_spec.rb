require 'rails_helper'

RSpec.describe "stocks/show", type: :view do
  before(:each) do
    @stock = assign(:stock, Stock.create!(
      user_id: 2,
      stock_name: "Stock Name",
      price: "9.99",
      quantity: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Stock Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
  end
end
