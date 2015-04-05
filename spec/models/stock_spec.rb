require 'rails_helper'

describe Stock do

  before(:each) do
    @stock = new_stock
  end

  describe 'validations' do

    it 'must have a name' do
      expect(@stock).to be_valid
      @stock.name = nil
      expect(@stock).to_not be_valid
    end

    it 'must have a ticker symbol' do
      expect(@stock).to be_valid
      @stock.ticker_symbol = nil
      expect(@stock).to_not be_valid
    end

    it 'must have a unique name and ticker symbol' do
      expect(@stock).to be_valid
      create_stock
      expect(@stock).to_not be_valid
      @stock.name = 'American Express'
      expect(@stock).to_not be_valid
      @stock.ticker_symbol = 'AXP'
      expect(@stock).to be_valid
    end

  end

  describe 'fetch_and_save_current_price' do

    it 'returns false if it has already been fetched within the last day' do
      stock = create_stock
      StockPrice.create!(stock_id: stock.id)

      expect(stock.fetch_and_save_current_price).to eq(false)
      expect(StockPrice.count).to eq(1)
    end

    it 'fetches the stocks quote and saves it if it does not have it' do
      VCR.use_cassette('models/stock/stock_price_fetch_and_save') do
        stock = create_stock
        stock.fetch_and_save_current_price

        stock_price = stock.stock_prices.first
        expect(stock_price.open).to eq('N/A')
        expect(stock_price.previous_close).to eq('N/A')
        expect(stock_price.year_high).to eq('N/A')
        expect(stock_price.year_low).to eq('N/A')
        expect(stock_price.days_high).to eq('N/A')
        expect(stock_price.days_low).to eq('N/A')
        expect(stock_price.bid_realtime).to eq('N/A')
        expect(stock_price.market_cap).to eq('158.54B')
        expect(stock_price.last_trade_price).to eq('160.40')
      end
    end

  end

  describe 'fetch_and_save_new_articles' do
    include ActiveSupport::Testing::TimeHelpers

    it 'fetches the articles and saves them' do
      VCR.use_cassette('models/stock/article_fetch_and_save') do
        date = DateTime.parse('Sat, 04 Apr 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          stock.fetch_and_save_new_articles

          expect(Article.count).to eq(21)
          article = Article.last
          expect(article.title).to eq('Klaus Tschira, Business Software Trailblazer, Dies at 74 ')
        end
      end
    end

    it 'skips an article if it has already been saved' do
      VCR.use_cassette('models/stock/article_fetch_and_save_repeat') do
        stock = create_stock
        stock.fetch_and_save_new_articles

        expect(Article.count).to eq(20)

        stock.fetch_and_save_new_articles

        expect(Article.count).to eq(20)
      end
    end

  end

  describe 'fetch_and_save_new_tweets' do

    it 'fetches tweets and saves them' do
      VCR.use_cassette('models/stock/fetch_and_save_new_tweets') do
        stock = create_stock
        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(100)
        tweet = Tweet.last
        expect(tweet.data['metadata']['result_type']).to eq('recent')
      end
    end

    it 'does not resave the same tweet' do
      VCR.use_cassette('models/stock/fetch_and_save_new_repeat') do
        stock = create_stock
        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(100)

        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(100)
      end
    end

  end

  describe 'all_time_positivity_score' do

    it 'returns the all time positivity score' do
      stock = create_stock
      create_article(stock_id: stock.id, positivity_score: 50)

      expect(stock.all_time_positivity_score).to eq(50)
    end

    it 'returns the average off all positivity scores when there are more than 1' do
      stock = create_stock
      create_article(stock_id: stock.id, positivity_score: 60)
      create_article(stock_id: stock.id, positivity_score: 50)

      expect(stock.all_time_positivity_score).to eq(55)
    end

    it 'returns a rounded score if it is not an integer' do
      stock = create_stock
      create_article(stock_id: stock.id, positivity_score: 55)
      create_article(stock_id: stock.id, positivity_score: 50)

      expect(stock.all_time_positivity_score).to eq(53)
    end

    it 'ignores positivity scores of nil' do
      stock = create_stock
      create_article(stock_id: stock.id, positivity_score: 55)
      create_article(stock_id: stock.id)

      expect(stock.all_time_positivity_score).to eq(55)
    end

    it 'returns nil if there are no positivity scores' do
      stock = create_stock
      create_article(stock_id: stock.id)

      expect(stock.all_time_positivity_score).to eq(nil)
    end

    it 'averages tweet scores along with article scores' do
      stock = create_stock
      create_article(stock_id: stock.id, positivity_score: 55)
      create_tweet(stock_id: stock.id, positivity_score: 65)
      expect(stock.all_time_positivity_score).to eq(60)
    end

  end

end