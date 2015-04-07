module Api
  module V1
    class StocksController < ApplicationController

      def index
        stocks = Stock.order(ticker_symbol: :asc)
        render status: 200, json: stocks
      end

      def show
        stock = Stock.find(params[:id])
        json = stock.attributes.merge(
          all_time_positivity_score: stock.all_time_positivity_score
        )
        render status: 200, json: json
      end

      def stock_prices
        stock = Stock.find(params[:id])
        stock_prices = stock.stock_prices.last(5)
        render status: 200, json: stock_prices
      end

      def tweets
        stock = Stock.find(params[:id])
        tweets = stock.tweets.last(5)
        render status: 200, json: tweets
      end

      def articles
        stock = Stock.find(params[:id])
        articles = stock.articles.last(5)
        render status: 200, json: articles
      end

    end
  end
end