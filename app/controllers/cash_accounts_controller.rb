class CashAccountsController < ApplicationController
    # before_action :authenticate_user!, except: [:new, :create]
    # before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @cash_accounts = CashAccount.all
  end

  def deposit
    @cash_account = CashAccount.new
  end

  def widthdraw
    @cash_account = CashAccount.new
  end

end
