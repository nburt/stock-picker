class ArticleFetcher::UsaToday < ArticleFetcher

  def self.fetch(query)
    url = create_url(query)
    response = Typhoeus.get(url)

    parse_articles(response.body)
  end

  private

  def self.parse_articles(body)
    parsed_body = Oj.load(body)

    return [] unless parsed_body

    parsed_body["stories"].map do |article|
      hash = {
        title: article["title"],
        description: article["description"],
        date: article["pubDate"],
        link: article["link"],
        data: article,
        source: "USA Today"
      }

      ArticleResponse.new(hash)
    end

  end

  def self.create_url(query)
    "http://api.usatoday.com/open/articles?keyword=#{query}&api_key="+
      "#{ENV["USA_TODAY_API_KEY"]}&encoding=json&days=1&tickers_only=Y"
  end

end