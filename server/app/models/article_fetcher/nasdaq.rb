class ArticleFetcher::Nasdaq < ArticleFetcher::Rss

  def self.fetch(ticker_symbol)
    url = create_url(ticker_symbol)
    response = Typhoeus.get(url)
    parse_articles(response.body, "Nasdaq")
  end

  private

  def self.create_url(ticker_symbol)
    "http://articlefeeds.nasdaq.com/nasdaq/symbols?symbol=#{ticker_symbol}"
  end

end