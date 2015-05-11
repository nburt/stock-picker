class BingSearcher

  def self.search_all(query)
    BingSearcher::MarketWatch.search(query)
  end

end