require 'rails_helper'

describe 'stocks api' do

  describe 'index' do

    it 'returns basic information about all the stocks' do
      stock = create_stock
      stock_2 = create_stock({name: 'American Express', ticker_symbol: 'AXP'})

      expected = [stock_2.attributes, stock.attributes].to_json

      get '/api/v1/stocks'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected)
    end

  end

  describe 'show' do

    it 'returns basic information about a stock' do
      stock = create_stock

      get "/api/v1/stocks/#{stock.id}"

      expected = stock.attributes.merge(
        all_time_positivity_score: stock.all_time_positivity_score
      ).to_json

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected)
    end

  end

  describe 'stock_prices' do

    it 'returns stock prices for a stock' do
      stock = create_stock
      stock_price = create_stock_price(stock_id: stock.id)

      get "/api/v1/stocks/#{stock.id}/stock_prices"

      expect(response.status).to eq(200)
      expect(response.body).to eq([stock_price.attributes].to_json)
    end

  end

  describe 'tweets' do

    it 'returns tweets for a stock' do
      stock = create_stock
      tweet = create_tweet(stock_id: stock.id)

      get "/api/v1/stocks/#{stock.id}/tweets"

      expect(response.status).to eq(200)
      expect(response.body).to eq([tweet.attributes].to_json)
    end

  end

  describe 'articles' do

    it 'returns articles for a stock' do
      stock = create_stock
      article = create_article(stock_id: stock.id)

      get "/api/v1/stocks/#{stock.id}/articles"

      expect(response.status).to eq(200)
      expect(response.body).to eq([article.attributes].to_json)
    end

  end

end