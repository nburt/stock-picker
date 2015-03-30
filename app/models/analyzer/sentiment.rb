class Analyzer::Sentiment < Analyzer

  def analyze!
    title_response = sentiment_request(@article.title)
    title_sentiment_score = parse_score(title_response.body)

    description_sentiment_score = nil
    if @article.description.present?
      description_response = sentiment_request(@article.description)
      description_sentiment_score = parse_score(description_response.body)
    end

    average_sentiment(title_sentiment_score, description_sentiment_score) if title_sentiment_score
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

  def parse_score(body)
    parsed_body = Oj.load(body)
    return nil unless parsed_body["docSentiment"]
    parsed_body["docSentiment"]["score"].to_f
  end

  def average_sentiment(title_score, description_score)
    if description_score
      average_score = (title_score + description_score) / 2.0
    else
      average_score = title_score
    end

    if average_score > 0
      type = "positive"
    elsif average_score < 0
      type = "negative"
    else
      type = "neutral"
    end

    {
      score: average_score,
      type: type
    }
  end

  def request_url
    "http://access.alchemyapi.com/calls/text/TextGetTextSentiment"
  end

end