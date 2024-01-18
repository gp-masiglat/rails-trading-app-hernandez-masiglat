class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, except: [:index]
  before_action :set_companies, only: %i[ index new ]
  before_action :set_stock, only: %i[ buy sell ]
  before_action :set_user, only: %i[ buy sell ]

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.role == 'Trader' ? Transaction.where(user_id: session[:user_id]) : Transaction.all
  end

  # GET /transactions/new/[stocks symbol]
  def new
    
    @transaction = Transaction.new
    @stock = Stock.new
    @user = User.find(session[:user_id])
    @company = @companies.find {|hash| hash[:symbol]==params[:symbol]}
  end

  # POST /transactions or /transactions.json
  def buy
    @stock = Stock.new(stock_params)
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      
      if @transaction.save
        
        @user.update(update_balance_params)
        
        if @stockExist.present?
          
          @stockExist.update(stock_params)
        else
          
          @stock.save
        end
        

        format.html { redirect_to transactions_path, notice: "Transaction was successfully created." }
        format.json { render :index, status: :created, location: @transactions }
        # format.html { redirect_to stock_url(@stock), notice: "Stocks was successfully created." }
        # format.json { render :create, status: :ok, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end

    end

  end

  def sell
    @stock = Stock.new(sell_params)
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|

      if @transaction.save
         @user.update(update_balance_params)
        if @stockExist.present?
          @stockExist.update(sell_params)
        end
        

        format.html { redirect_to transactions_path, notice: "Transaction was successfully created." }
        format.json { render :index, status: :created, location: @transactions }
        # format.html { redirect_to stock_url(@stock), notice: "Stocks was successfully created." }
        # format.json { render :create, status: :ok, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end

    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_stock
      @stockExist = Stock.where(user: params[:user_id]).where(symbol: params[:symbol])
    end

    def set_user
      @user = User.find(session[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params[:total_price] = params[:price].to_f * params[:number_of_stock].to_i
      params[:status] = 'ok'
      params.permit(:user_id, :transaction_type, :stock_name,:price, :number_of_stock, :total_price, :status)
    end

    def stock_params
      
          if @stockExist.present?
            @stockExist.each do |s|
              params[:quantity] = s.quantity.to_i + params[:number_of_stock].to_i
            end
            params.permit(:quantity)
          else
            params[:quantity] = params[:number_of_stock].to_i
            params.permit(:user_id, :symbol, :quantity)
          end
    end

    def sell_params

          if @stockExist.present?
            @stockExist.each do |s|
              params[:quantity] = s.quantity.to_i - params[:number_of_stock].to_i
            end
            params.permit(:quantity)
          end

    end

    def update_balance_params
      params[:total_price] = params[:price].to_f * params[:number_of_stock].to_i
      if params[:transaction_type] == 'Buy'
        params[:balance] = @user.balance.to_f - params[:total_price].to_f
      else
        params[:balance] = @user.balance.to_f + params[:total_price].to_f
      end
      params.permit(:balance)
    end

    def set_companies
      limited_companies = ['AMZN', 'AAPL', 'MSFT', 'TSLA', 'BAC']
      # limited_companies = ['AMZN', 'AAPL']
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
      # logo = client.logo(symbol)
      {
          symbol: symbol,
          # name: company_info.company_name,
          price: price,
          # logo: logo.url,
          # description: company_info.description
        }
    end
end
