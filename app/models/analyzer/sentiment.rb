class Analyzer::Sentiment < Analyzer

  protected

  def parse_body(body)
    parsed_body = Oj.load(body)
    return nil unless parsed_body["docSentiment"]
    sentiment = parsed_body["docSentiment"]
    {
      score: sentiment["score"].to_f,
      type: sentiment["type"]
    }
  end

end