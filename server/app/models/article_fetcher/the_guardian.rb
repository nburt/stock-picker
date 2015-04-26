class ArticleFetcher::TheGuardian < ArticleFetcher

  def self.fetch(query)
    url = create_url(query)

    response = Typhoeus.get(url)
    parse_articles(response.body)
  end

  private

  def self.parse_articles(body)
    parsed_body = Oj.load(body)

    parsed_body["response"]["results"].map do |article|
      hash = {
        title: article["webTitle"],
        section: [article["sectionName"]],
        date: article["webPublicationDate"],
        link: article["webUrl"],
        data: article,
        source: "The Guardian"
      }

      ArticleResponse.new(hash)
    end

  end

  def self.create_url(query)
    from_date = 1.day.ago.strftime("%Y-%m-%d")
    to_date = Date.today.strftime("%Y-%m-%d")
    "http://content.guardianapis.com/search?api-key=#{ENV["THE_GUARDIAN_API_KEY"]}&" +
      "q=#{query}&from-date=#{from_date}&to-date=#{to_date}"
  end

end