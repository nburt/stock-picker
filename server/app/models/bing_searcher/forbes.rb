class BingSearcher::Forbes < BingSearcher

  def self.search(term)
    articles = []
    skip = 0

    4.times.flat_map do
      response = Typhoeus.get(search_url(term, skip), userpwd: ":#{ENV['BING_SEARCH_API_KEY']}")
      parsed_body = Oj.load(response.body)
      results = parsed_body["d"]["results"]
      results.map do |result|
        articles << BingSearcher::Response.new(result)
      end

      skip += 50
    end
    articles
  end

  private

  def self.create_query(term)
    CGI::escape("site:www.forbes.com \"#{term}\"")
  end


end