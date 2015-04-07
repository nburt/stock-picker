class ArticleFetcher::NewYorkTimes < ArticleFetcher

  def self.fetch(ticker_symbol)
    url = create_url(ticker_symbol)
    response = Typhoeus::Request.get(url, {followlocation: true})

    parse_articles(response.body)
  end

  private

  def self.create_url(ticker_symbol)
    api_key = ENV["NY_TIMES_ARTICLE_SEARCH_KEY"]
    begin_date = Date.today.strftime("%Y%m%d")
    "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{ticker_symbol}&" <<
      "begin_date=#{begin_date}&api-key=#{api_key}"
  end

  def self.parse_articles(body)
    parsed_body = Oj.load(body)
    articles = parsed_body["response"]["docs"]
    articles.map do |article|
      hash = {
        title: article["headline"]["main"],
        description: article["snippet"],
        date: article["pub_date"],
        link: article["web_url"],
        data: article,
        source: "New York Times"
      }

      ArticleResponse.new(hash)
    end
  end

end