require "rails_helper"

RSpec.describe CashAccountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cash_account").to route_to("cash_accounts#index")
    end

    it "routes to #new" do
      expect(get: "/cash_account/new").to route_to("cash_accounts#new")
    end

    it "routes to #create" do
      expect(post: "/cash_account/create").to route_to("cash_accounts#create")
    end
  end
end
