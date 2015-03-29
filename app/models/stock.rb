class Stock < ActiveRecord::Base
  has_many :stock_prices

  validates_presence_of :name, :ticker_symbol
  validates_uniqueness_of :name, :ticker_symbol

  def fetch_and_save_current_price
    already_fetched = stock_prices.last && stock_prices.last.created_at.strftime('%D') == DateTime.now.strftime('%D')
    return false if already_fetched

    quote = StockPriceFetcher.fetch!(ticker_symbol)
    # open, previous close, year high, year low, days high, days low, bid (realtime), market cap, last trade price

    attributes = {
      stock_id: id, open: quote.open, previous_close: quote.previous_close,
      year_high: quote.year_high, year_low: quote.year_low, days_high: quote.days_high,
      days_low: quote.days_low, bid_realtime: quote.bid_realtime, market_cap: quote.market_cap,
      last_trade_price: quote.last_trade_price
    }
    StockPrice.create!(attributes)
  end

end
