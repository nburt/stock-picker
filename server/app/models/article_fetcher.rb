class ArticleFetcher

  def self.fetch(ticker_symbol)
    fetchers.map do |fetcher|
      fetcher.fetch(ticker_symbol)
    end.flatten
  end

  private

  def self.fetchers
    [ArticleFetcher::YahooFinance, ArticleFetcher::NewYorkTimes]
  end

end