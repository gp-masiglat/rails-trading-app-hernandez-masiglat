class CashAccountsController < ApplicationController
    # before_action :authenticate_user!, except: [:new, :create]
    # before_action :set_user, only: %i[ show edit update destroy ]

  def index
    
    @user = User.find(session[:user_id])
    @cash_accounts = CashAccount.where(user_id: @user.id)
    sum_depo = CashAccount.where(user_id: @user.id, trans_type: 'Deposit').sum(:amount)
    sum_widthdraw = CashAccount.where(user_id: @user.id,trans_type:'Widthdraw').sum(:amount)
    @ca_balance = sum_depo - sum_widthdraw

  end

  def new
    @cash_account = CashAccount.new
  end

  def create
    @cash_account = CashAccount.new(ca_params)
    @cash_account.user_id =session[:user_id]

    respond_to do |format|
      if @cash_account.save

        format.html { redirect_to cash_account_path, notice: "Transaction is successfull!" }
        format.json { render :show, status: :created, location: @cash_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cash_account.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_user
    @user = User.find(session[:user_id])
  end

  def ca_params
    params.require(:cash_account).permit(:bank_name, :account_number,:user_id, :amount, :status, :trans_type)
  end

end
