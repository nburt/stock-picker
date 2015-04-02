class ArticleFetcher

  def self.fetch(ticker_symbol)
    url = create_url(ticker_symbol)
    response = Typhoeus::Request.get(url, {followlocation: true})


    parse_articles(response.body)
  end

  private

  def self.create_url(ticker_symbol)
    "http://finance.yahoo.com/rss/headline?s=#{ticker_symbol}"
  end

  def self.parse_articles(body)
    articles = Nokogiri::XML(body)
    articles.xpath("//item").map do |item|
      hash = {}
      item.children.each do |child|
        case child.name
          when "title"
            hash[:title] = child.text
          when "description"
            hash[:description] = child.text
          when "pubDate"
            hash[:date] = child.text
          when "link"
            hash[:link] = child.text
        end
      end
      ArticleResponse.new(hash)
    end
  end

end