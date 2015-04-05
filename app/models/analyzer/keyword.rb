class Analyzer::Keyword < Analyzer

  protected

  def dedup_and_sort(articles)
    sorted_by_relevance = articles.sort { |a, b| b[:relevance] <=> a[:relevance] }
    sorted_by_relevance.uniq { |article| article[:text].downcase }
  end

  def format_response(body, type)
    parsed_body = Oj.load(body)
    return [] unless parsed_body[type]
    parsed_body[type].map do |result|
      sentiment = result.fetch("sentiment", {})
      sentiment_hash = {
        score: sentiment["score"].to_f,
        type: sentiment["type"]
      }
      {
        text: result["text"],
        relevance: result["relevance"],
        sentiment: sentiment_hash
      }
    end
  end

end