class Stock < ActiveRecord::Base
  has_many :stock_prices
  has_many :articles
  has_many :tweets
  has_many :reddits

  validates_presence_of :name, :ticker_symbol
  validates_uniqueness_of :name, :ticker_symbol

  def fetch_and_save_prices
    latest_date = stock_prices.order(:date).first.date
    quotes = StockPriceFetcher.fetch!(ticker_symbol, latest_date)

    quotes.each do |quote|
      attributes = {
        stock_id: id, open: quote.open, close: quote.close,
        days_high: quote.days_high, days_low: quote.days_low,
        volume: quote.volume, adj_close: quote.adj_close, date: DateTime.parse(quote.date)
      }

      existing_price = StockPrice.find_by(stock_id: id, date: DateTime.parse(quote.date))

      next if existing_price

      StockPrice.create!(attributes)
    end
  end

  def fetch_and_save_new_articles
    articles = ArticleFetcher.fetch_all(ticker_symbol)
    articles.each do |article|
      find_by_attributes = {
        stock_id: id, title: article.title, link: article.link,
        source: article.source
      }

      existing_article = Article.find_by(find_by_attributes)
      next if existing_article

      attributes = find_by_attributes.merge({data: article.data, section: article.section,
                                             description: article.description,
                                             date: DateTime.parse(article.date)})
      Article.create!(attributes)
    end
  end

  def search_and_save_articles
    articles = BingSearcher.search_all(name)

    articles.each do |article|

      find_by_attributes = {
        stock_id: id, title: article.title, link: article.link,
        source: article.source
      }

      existing_article = Article.find_by(find_by_attributes)
      next if existing_article

      attributes = find_by_attributes.merge({date: DateTime.parse(article.date),
                                             description: article.description})
      Article.create!(attributes)
    end
  end

  def fetch_and_save_new_tweets(term = nil)
    term = term ? term : "$#{ticker_symbol}"
    searcher = TweetSearcher.new(term)
    tweets = searcher.search

    tweets.each do |tweet|
      existing_tweet = Tweet.find_by("data->>'id_str' = ? OR data->>'text' = ?", tweet[:id_str], tweet[:text])
      next if existing_tweet

      Tweet.create!(data: tweet, stock_id: id)
    end
  end

  def fetch_and_save_reddits(term = nil)
    reddits = RedditSearcher.search(term)

    reddits.each do |reddit|
      find_by_attributes = {
        stock_id: id, title: reddit.title, link: reddit.link,
        date: reddit.date, subreddit_id: reddit.subreddit_id
      }

      existing_reddit = Reddit.find_by(find_by_attributes)
      next if existing_reddit

      attributes = find_by_attributes.merge(data: reddit.data)
      Reddit.create!(attributes)
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
