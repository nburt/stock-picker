class Analyzer::Keyword::UrlKeyword < Analyzer::Keyword

  def analyze!
    return [] unless @content.present?

    keyword_analysis = analyze_keywords
    entity_analysis = analyze_entities
    merged_keywords = keyword_analysis.concat(entity_analysis)
    dedup_and_sort(merged_keywords)
  end

  private

  def analyze_keywords
    response = Typhoeus::Request.new(
      keyword_request_url,
      method: :post,
      body: {
        apikey: @api_key,
        url: @content,
        outputMode: "json"
      }
    ).run

    format_response(response.body, "keywords")
  end

  def analyze_entities
    response = Typhoeus::Request.new(
      entity_request_url,
      method: :post,
      body: {
        apikey: @api_key,
        url: @content,
        outputMode: "json"
      }
    ).run

    format_response(response.body, "entities")
  end

  def keyword_request_url
    "http://access.alchemyapi.com/calls/url/URLGetRankedKeywords?sentiment=1"
  end

  def entity_request_url
    "http://access.alchemyapi.com/calls/url/URLGetRankedNamedEntities?sentiment=1"
  end

end