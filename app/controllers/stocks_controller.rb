class StocksController < ApplicationController

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(strong_params)

    if @stock.save
      redirect_to(root_path)
    else
      render :new
    end
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])

    if @stock.update_attributes(strong_params)
      redirect_to(stock_path(@stock))
    else
      render :edit
    end
  end

  private

  def strong_params
    params.require(:stock).permit(:name, :ticker_symbol, :twitter_handle)
  end

end