class RedditSearcher

  def self.search(name)
    url = create_url(name)

    response = Typhoeus.get(url)

    parse_body(response.body)
  end

  private

  def self.create_url(name)
    URI.encode("http://www.reddit.com/r/stocks/search.json?q=#{name}&sort=new&t=day")
  end

  def self.parse_body(body)
    Oj.load(body)["data"]["children"].map do |child|
      RedditResponse.new(child)
    end
  end

end