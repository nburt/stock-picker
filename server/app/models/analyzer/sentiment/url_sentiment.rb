class Analyzer::Sentiment::UrlSentiment < Analyzer::Sentiment

  def analyze!
    return unless @content.present?
    response = sentiment_request(@content)
    parse_body(response.body)
  end

  private

  def sentiment_request(url)
    Typhoeus::Request.new(
      request_url,
      method: :post,
      body: {
        apikey: @api_key,
        url: url,
        outputMode: "json"
      }
    ).run
  end

  def request_url
    "http://access.alchemyapi.com/calls/url/URLGetTextSentiment"
  end

end