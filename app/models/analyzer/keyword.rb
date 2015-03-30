class Analyzer::Keyword < Analyzer

  def analyze!
    keyword_analysis = analyze_keywords
    entity_analysis = analyze_entities
    merged_keywords = keyword_analysis.concat(entity_analysis)
    dedup_and_sort(merged_keywords)
  end

  private

  def analyze_keywords
    title_response = keywords_request(@article.title).body
    description_response = []

    if @article.description.present?
      description_response = format_response(keywords_request(@article.description).body, "keywords")
    end

    format_response(title_response, "keywords").concat(description_response)
  end

  def analyze_entities
    title_response = entities_request(@article.title).body

    description_response = []

    if @article.description.present?
      description_response = format_response(entities_request(@article.description).body, "entities")
    end

    format_response(title_response, "entities").concat(description_response)
  end

  def dedup_and_sort(articles)
    sorted_by_relevance = articles.sort { |a, b| b[:relevance] <=> a[:relevance] }
    sorted_by_relevance.uniq { |article| article[:text].downcase }
  end

  def format_response(body, type)
    parsed_body = Oj.load(body)
    parsed_body[type].map do |result|
      sentiment_hash = {
        score: result["sentiment"]["score"].to_f,
        type: result["sentiment"]["type"]
      }
      {
        text: result["text"],
        relevance: result["relevance"],
        sentiment: sentiment_hash
      }
    end
  end

  def keywords_request(text)
    Typhoeus::Request.new(
      keyword_request_url,
      method: :post,
      body: {
        apikey: @api_key,
        text: text,
        outputMode: "json"
      }
    ).run
  end

  def entities_request(text)
    Typhoeus::Request.new(
      entity_request_url,
      method: :post,
      body: {
        apikey: @api_key,
        text: text,
        outputMode: "json"
      }
    ).run
  end

  def keyword_request_url
    "http://access.alchemyapi.com/calls/text/TextGetRankedKeywords?sentiment=1"
  end

  def entity_request_url
    "http://access.alchemyapi.com/calls/text/TextGetRankedNamedEntities?sentiment=1"
  end

end