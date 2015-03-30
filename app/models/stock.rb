class Stock < ActiveRecord::Base
  has_many :stock_prices
  has_many :articles

  validates_presence_of :name, :ticker_symbol
  validates_uniqueness_of :name, :ticker_symbol

  def fetch_and_save_current_price
    already_fetched = stock_prices.last &&
      stock_prices.last.created_at.strftime('%D') == DateTime.now.new_offset(0).strftime('%D')
    return false if already_fetched

    quote = StockPriceFetcher.fetch!(ticker_symbol)

    attributes = {
      stock_id: id, open: quote.open, previous_close: quote.previous_close,
      year_high: quote.year_high, year_low: quote.year_low, days_high: quote.days_high,
      days_low: quote.days_low, bid_realtime: quote.bid_realtime, market_cap: quote.market_cap,
      last_trade_price: quote.last_trade_price
    }
    StockPrice.create!(attributes)
  end

  def fetch_and_save_new_articles
    articles = ArticleFetcher.fetch!(ticker_symbol)
    articles.each do |article|
      attributes = {
        stock_id: id, title: article.title, date: article.date, link: article.link,
        description: article.description
      }

      article = Article.find_by(attributes)
      next if article

      Article.create!(attributes)
    end
  end

end
