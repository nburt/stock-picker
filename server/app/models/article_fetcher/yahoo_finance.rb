class ArticleFetcher::YahooFinance < ArticleFetcher::Rss

  def self.fetch(ticker_symbol)
    url = create_url(ticker_symbol)
    response = Typhoeus::Request.get(url, {followlocation: true})

    parse_articles(response.body, "Yahoo Finance")
  end

  private

  def self.create_url(ticker_symbol)
    "http://finance.yahoo.com/rss/headline?s=#{ticker_symbol}"
  end

end