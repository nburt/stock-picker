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

  private

  def strong_params
    params.require(:stock).permit(:name, :ticker_symbol)
  end

end