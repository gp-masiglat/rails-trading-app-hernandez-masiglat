class CashAccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!
    before_action :set_user

  def index
  end

  def new
    @cash_account = @user.cash_accounts.new
  end

  def create
    @cash_account = @user.cash_accounts.new(ca_params)
      # Update user balance
      new_balance = ca_params[:trans_type] == 'Deposit'? @user.balance + BigDecimal(ca_params[:amount]) : @user.balance - BigDecimal(ca_params[:amount])

    respond_to do |format|
      if @user.update({'balance' => new_balance})
        if @cash_account.save
          
          format.html { redirect_to cash_account_path, notice: "Transaction is successfull!" }
          format.json { render :show, status: :created, location: @cash_account }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @cash_account.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
  def set_user
    @user = User.find(session[:user_id])
    @cash_accounts = @user.cash_accounts
  end

  def ca_params
    params.require(:cash_account).permit(:bank_name, :account_number,:user_id, :amount, :status, :trans_type)
  end

end
