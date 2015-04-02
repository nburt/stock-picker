class WelcomeController < ApplicationController

  def index
    @stocks = Stock.order(ticker_symbol: :asc)
  end

end