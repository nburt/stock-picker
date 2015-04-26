class ArticleFetcher::Rss < ArticleFetcher

  protected

  def self.parse_articles(body, source)
    articles = Nokogiri::XML(body)
    articles.xpath("//item").map do |item|
      hash = {
        source: source
      }
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