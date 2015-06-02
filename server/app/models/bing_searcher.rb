class BingSearcher

  def self.search_all(query)
    [BingSearcher::MarketWatch, BingSearcher::MarketWatch].flat_map do |searcher|
      searcher.search(query)
    end
  end

  private

  def self.search_url(term, skip)
    "https://api.datamarket.azure.com/Bing/Search/v1/News?Query='#{create_query(term)}'&$format=json&$top=50&$skip=#{skip}"
  end

end