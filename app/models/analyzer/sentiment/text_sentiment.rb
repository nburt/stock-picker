class Analyzer::Sentiment::TextSentiment < Analyzer::Sentiment

  def analyze!
    return unless @content.present?
    response = sentiment_request(@content)
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

  def request_url
    "http://access.alchemyapi.com/calls/text/TextGetTextSentiment"
  end

end