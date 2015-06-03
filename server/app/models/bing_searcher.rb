class BingSearcher

  def self.search_all(query)
    sites.flat_map do |searcher|
      searcher.search(query)
    end
  end

  private

  def self.search_url(term, skip)
    "https://api.datamarket.azure.com/Bing/Search/v1/News?Query='#{create_query(term)}'&$format=json&$top=50&$skip=#{skip}"
  end

  def self.sites
    [BingSearcher::MarketWatch, BingSearcher::MarketWatch, BingSearcher::Bloomberg]
  end

end