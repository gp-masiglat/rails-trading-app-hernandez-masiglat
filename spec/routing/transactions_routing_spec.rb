require "rails_helper"

RSpec.describe TransactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/transactions").to route_to("transactions#index")
    end

    it "routes to #new" do
      expect(get: "/transactions/new/AMZN").to route_to("transactions#new", symbol: 'AMZN')
    end

    it "routes to #buy" do
      expect(post: "/transactions/buy").to route_to("transactions#buy")
    end
    
    it "routes to #sell" do
      expect(post: "/transactions/sell").to route_to("transactions#sell")
    end
  end
end
