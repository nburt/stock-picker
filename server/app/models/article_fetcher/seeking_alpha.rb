class ArticleFetcher::SeekingAlpha < ArticleFetcher::Rss

  def self.fetch(ticker_symbol)
    url = create_url(ticker_symbol)
    response = Typhoeus.get(url)
    parse_articles(response.body, "Seeking Alpha")
  end

  private

  def self.create_url(ticker_symbol)
    "http://seekingalpha.com/api/sa/combined/#{ticker_symbol}.xml"
  end

end