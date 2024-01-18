class StocksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authorize_user!, except: [:index]
  before_action :set_stock, only: %i[ edit update destroy ]
  before_action :set_companies, only: %i[ index show ]

  # GET /stocks or /stocks.json
  def index
    redirect_to users_path if current_user.role == 'Admin'
    if current_user
      @user = User.find(current_user.id)
      @stocks = @user.stocks
      @portfolio = []

      @stocks.each do |stock|
        @portfolio << get_company_info(stock.symbol).merge(:quantity=>stock.quantity)
      end
    end
  end

  # GET /stocks/1 or /stocks/1.json
  def show
    @company = @companies.find {|hash| hash[:symbol]==params[:symbol]}
    if current_user
      @user = User.find(current_user.id)
      @stock = @user.stocks.find_by(symbol: params[:symbol])
    end
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy!

    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:user_id, :stock_name, :price, :quantity, :symbol)
    end

    # set companies to be shown in index page
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
