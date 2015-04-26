class ArticleFetcher

  def self.fetch_all(ticker_symbol)
    fetchers.map do |fetcher|
      fetcher.fetch(ticker_symbol)
    end.flatten
  end

  private

  def self.fetchers
    [
      ArticleFetcher::YahooFinance, ArticleFetcher::NewYorkTimes,
      ArticleFetcher::TheGuardian, ArticleFetcher::UsaToday,
      ArticleFetcher::SeekingAlpha, ArticleFetcher::Nasdaq
    ]
  end

end