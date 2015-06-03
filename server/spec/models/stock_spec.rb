require 'rails_helper'

describe Stock do

  include ActiveSupport::Testing::TimeHelpers

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

  describe 'fetch_and_save_prices' do

    it 'fetches the stocks price information since the latest saved data' do
      VCR.use_cassette('models/stock/stock_price_fetch_and_save') do
        date = DateTime.parse('Mon, 01 Jun 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          create_stock_price(stock_id: stock.id, date: 20.days.ago)

          stock.fetch_and_save_prices

          expect(stock.stock_prices.count).to eq(16)
          stock_price = stock.stock_prices.last
          expect(stock_price.date).to eq('Tue, 12 May 2015 00:00:00 UTC +00:00')
          expect(stock_price.open).to eq('170.55')
          expect(stock_price.days_high).to eq('171.49001')
          expect(stock_price.days_low).to eq('168.84')
          expect(stock_price.close).to eq('170.55')
          expect(stock_price.volume).to eq(2928600)
          expect(stock_price.adj_close).to eq('170.55')
        end
      end
    end

    it 'does not resave a quote from the same day' do
      VCR.use_cassette('models/stock/stock_price_fetch_and_save_repeat') do
        date = DateTime.parse('Mon, 01 Jun 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          create_stock_price(stock_id: stock.id, date: 20.days.ago)

          stock.fetch_and_save_prices

          expect(stock.stock_prices.count).to eq(16)

          stock.fetch_and_save_prices

          expect(stock.stock_prices.count).to eq(16)
        end
      end
    end

  end

  describe 'fetch_and_save_new_articles' do

    it 'fetches the articles and saves them' do
      VCR.use_cassette('models/stock/article_fetch_and_save') do
        date = DateTime.parse('Sun, 04 Apr 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          stock.fetch_and_save_new_articles

          expect(Article.count).to eq(92)
          article = Article.last
          expect(article.title).to eq('Rackspace Hosting Profit Rises 12%')
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
        date = DateTime.parse('Mon, 01 Jun 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          stock.search_and_save_articles

          expect(stock.articles.count).to eq(46)
          article = Article.first
          expect(article.title).to eq('IBM-Affiliated Brooklyn School Graduates Its First Students Ahead of Schedule With Both High School & College STEM Degrees')
          expect(article.date).to eq('Tue, 02 Jun 2015 01:03:56 UTC +00:00')
          expect(article.description).to eq('BROOKLYN, N.Y., June 2, 2015 /PRNewswire/ -- Six students from Brooklyn are graduating from P-TECH (Pathways in Technology Early College High School) two years early with both their high school diplomas and college degrees in computer systems technology ...')
          expect(article.source).to eq('Market Watch')
          expect(article.link).to eq('http://www.marketwatch.com/story/ibm-affiliated-brooklyn-school-graduates-its-first-students-ahead-of-schedule-with-both-high-school-college-stem-degrees-2015-06-02')
        end
      end
    end

    it 'does not save the same bing search article twice' do
      VCR.use_cassette('models/stock/search_and_save_articles_repeat') do
        date = DateTime.parse('Mon, 01 Jun 2015 19:57:00 UTC +00:00 ')
        travel_to(date) do
          stock = create_stock
          stock.search_and_save_articles

          expect(stock.articles.count).to eq(46)

          stock.search_and_save_articles

          expect(stock.articles.count).to eq(46)
        end
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