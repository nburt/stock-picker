class StockPriceFetcher

  # open, previous close, year high, year low, days high, days low, bid (realtime), market cap, last trade price
  PRICE_FORMATS = ["o0", "p0", "k0", "j0", "h0", "g0", "b3", "j1", "l1"]

  def self.fetch(ticker_symbol)
    url = create_url(ticker_symbol)
    response = Typhoeus::Request.get(url, {followlocation: true})
    StockPriceResponse.new(response.body)
  end

  private

  def self.create_url(ticker_symbol)
    format = PRICE_FORMATS.join
    "http://finance.yahoo.com/d/quotes.csv?s=#{ticker_symbol}&f=#{format}"
  end

end