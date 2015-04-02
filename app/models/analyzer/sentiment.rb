class Analyzer::Sentiment < Analyzer

  def analyze!
    return unless @text.present?
    response = sentiment_request(@text)
    parse_body(response.body)
  end

  private

  def sentiment_request(text)
    Typhoeus::Request.new(
      request_url,
      method: :post,
      body: {
        apikey: @api_key,
        text: text,
        outputMode: "json"
      }
    ).run
  end

  def parse_body(body)
    parsed_body = Oj.load(body)
    return nil unless parsed_body["docSentiment"]
    sentiment = parsed_body["docSentiment"]
    {
      score: sentiment["score"].to_f,
      type: sentiment["type"]
    }
  end

  def request_url
    "http://access.alchemyapi.com/calls/text/TextGetTextSentiment"
  end

end