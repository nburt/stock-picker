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
        date = DateTime.parse('Sun, 04 Apr 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          stock.fetch_and_save_new_articles

          expect(Article.count).to eq(92)
          article = Article.last
          expect(article.title).to eq('Stocks Turn Mixed After Moving Higher At The Open - U.S. Commentary')
          expect(article.section).to eq(nil)
        end
      end
    end

    it 'skips an article if it has already been saved' do
      VCR.use_cassette('models/stock/article_fetch_and_save_repeat') do
        date = DateTime.parse('Sun, 05 Apr 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          stock.fetch_and_save_new_articles

          expect(Article.count).to eq(92)

          stock.fetch_and_save_new_articles

          expect(Article.count).to eq(92)
        end
      end
    end

  end

  describe 'fetch_and_save_new_tweets' do

    it 'defaults to fetching tweets by searching for $ + the ticker symbol' do
      VCR.use_cassette('models/stock/fetch_and_save_new_tweets') do
        stock = create_stock
        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(88)
        tweet = Tweet.last
        expect(tweet.data['metadata']['result_type']).to eq('recent')
        expect(tweet.data['id_str']).to eq('582989806432485376')
      end
    end

    it 'accepts different arguments for different searches' do
      VCR.use_cassette('models/stock/fetch_and_save_new_tweets_search_2') do
        stock = create_stock
        stock.fetch_and_save_new_tweets('@IBM')

        expect(stock.tweets.count).to eq(84)
        tweet = Tweet.last
        expect(tweet.data['metadata']['result_type']).to eq('recent')
        expect(tweet.data['id_str']).to eq('587968937062703104')
      end
    end

    it 'does not resave the same tweet' do
      VCR.use_cassette('models/stock/fetch_and_save_new_repeat') do
        stock = create_stock
        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(85)

        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(85)
      end
    end

    it 'does not save tweets that have the same text' do
      VCR.use_cassette('models/stock/fetch_and_save_tweet_same_text') do
        stock = create_stock
        stock.fetch_and_save_new_tweets

        expect(stock.tweets.count).to eq(96)
      end
    end

  end

  describe 'fetch_and_save_reddits' do

    it 'fetches and saves reddits for a search term' do
      VCR.use_cassette('models/stock/fetch_and_save_reddit') do
        stock = create_stock
        stock.fetch_and_save_reddits(stock.name)

        expect(stock.reddits.count).to eq(24)

        reddit = Reddit.first
        expect(reddit.title).to eq('[help] Best place to buy an IBM Model M (Australia)?')
        expect(reddit.link).to eq('http://www.reddit.com/r/MechanicalKeyboards/comments/33z6tn/help_best_place_to_buy_an_ibm_model_m_australia/')
        expect(reddit.date).to eq('Mon, 27 Apr 2015 08:40:37 UTC +00:00')
        expect(reddit.data).to_not be_nil
        expect(reddit.subreddit_id).to eq('t5_2ugo7')
      end
    end

    it 'does not save the same reddits twice' do
      VCR.use_cassette('models/stock/fetch_and_save_reddit_repeat') do
        stock = create_stock
        stock.fetch_and_save_reddits(stock.name)

        expect(stock.reddits.count).to eq(24)

        stock.fetch_and_save_reddits(stock.name)

        expect(stock.reddits.count).to eq(24)
      end
    end
    
  end

  describe 'search_and_save_articles' do

    it 'searchs bing and saves articles for a search term' do
      VCR.use_cassette('models/stock/search_and_save_articles') do
        stock = create_stock
        stock.search_and_save_articles

        expect(stock.articles.count).to eq(34)

        article = Article.first
        expect(article.title).to eq('IBM Closes Acquisition of Phytel')
        expect(article.date).to eq('2015-05-04T17:30:22Z')
        expect(article.description).to eq('ARMONK, N.Y. and DALLAS, May 4, 2015 /PRNewswire/ -- IBM (NYSE: IBM) today announced it has completed the acquisition of Phytel, a leading provider of integrated population health management software based in Dallas, Texas. Financial terms of the deal were ...')
        expect(article.source).to eq('Market Watch')
        expect(article.link).to eq('http://www.marketwatch.com/story/ibm-closes-acquisition-of-phytel-2015-05-04')
      end
    end

    it 'does not save the same bing search article twice' do
      VCR.use_cassette('models/stock/search_and_save_articles_repeat') do
        stock = create_stock
        stock.search_and_save_articles

        expect(stock.articles.count).to eq(34)

        stock.search_and_save_articles

        expect(stock.articles.count).to eq(34)
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