class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :set_companies, only: %i[ index new ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new/[stocks symbol]
  def new
    # @transaction = Transaction.new
    @company = @companies.find {|hash| hash[:symbol]==params[:symbol]}
    @user = User.find(session[:user_id])
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    debugger
    params[:total_price] = 10
    @transaction = Transaction.new(transaction_params)
    
    
    # params[:transaction][:total_price] = params[:transaction][:price] * params[:transaction][:numbet_of_stock]


    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      
      params.require(:transaction).permit(:user_id, :transaction_type, :stock_name,:price, :number_of_stock, :total_price, :status)
      
    end

    def set_companies
      # limited_companies = ['AMZN', 'AAPL', 'MSFT', 'TSLA', 'BAC']
      limited_companies = ['AMZN', 'AAPL']
      @companies = []
      # @companies = @client.ref_data_symbols
      limited_companies.each do |symbol|
        @companies << get_company_info(symbol)
      end
    end

    def get_company_info(symbol)
      require 'iex-ruby-client'
      client = IEX::Api::Client.new
      price = client.price(symbol)
      company_info = client.company(symbol)
      logo = client.logo(symbol)
      {
          symbol: symbol,
          name: company_info.company_name,
          price: price,
          logo: logo.url,
          description: company_info.description
        }
    end
end
