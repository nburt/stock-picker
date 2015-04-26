class Stock < ActiveRecord::Base
  has_many :stock_prices
  has_many :articles
  has_many :tweets

  validates_presence_of :name, :ticker_symbol
  validates_uniqueness_of :name, :ticker_symbol

  def fetch_and_save_current_price
    already_fetched = stock_prices.last &&
      stock_prices.last.created_at.strftime('%D') == DateTime.now.new_offset(0).strftime('%D')
    return false if already_fetched

    quote = StockPriceFetcher.fetch(ticker_symbol)

    attributes = {
      stock_id: id, open: quote.open, previous_close: quote.previous_close,
      year_high: quote.year_high, year_low: quote.year_low, days_high: quote.days_high,
      days_low: quote.days_low, bid_realtime: quote.bid_realtime, market_cap: quote.market_cap,
      last_trade_price: quote.last_trade_price
    }
    StockPrice.create!(attributes)
  end

  def fetch_and_save_new_articles
    articles = ArticleFetcher.fetch_all(ticker_symbol)
    articles.each do |article|
      find_by_attributes = {
        stock_id: id, title: article.title, date: DateTime.parse(article.date), link: article.link,
        description: article.description, source: article.source
      }

      existing_article = Article.find_by(find_by_attributes)
      next if existing_article

      attributes = find_by_attributes.merge({data: article.data, section: article.section})
      Article.create!(attributes)
    end
  end

  def fetch_and_save_new_tweets(term = nil)
    term = term ? term : "$#{ticker_symbol}"
    searcher = TweetSearcher.new(term)
    tweets = searcher.search

    tweets.each do |tweet|
      existing_tweet = Tweet.where("data->>'id_str' = ?", tweet[:id_str])
      next if existing_tweet.any?

      Tweet.create!(data: tweet, stock_id: id)
    end
  end

  def all_time_positivity_score
    article_scores = articles.where("positivity_score IS NOT NULL").pluck(:positivity_score)
    tweet_scores = tweets.where("positivity_score IS NOT NULL").pluck(:positivity_score)
    return unless article_scores.any? || tweet_scores.any?
    all_scores = article_scores.concat(tweet_scores)
    (all_scores.sum.to_f / all_scores.size.to_f).round
  end

end
