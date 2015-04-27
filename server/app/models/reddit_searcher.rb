class RedditSearcher

  def self.search(ticker_symbol)
    url = create_url(ticker_symbol)

    response = Typhoeus.get(url)

    parse_body(response.body)
  end

  private

  def self.create_url(ticker_symbol)
    URI.encode("http://www.reddit.com/r/stocks/search.json?q=#{ticker_symbol}&sort=new&t=day")
  end

  def self.parse_body(body)
    Oj.load(body)["data"]["children"].map do |child|
      RedditResponse.new(child)
    end
  end

end