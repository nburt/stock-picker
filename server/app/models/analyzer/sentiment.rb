class Analyzer::ApiLimitReached < StandardError
end

class Analyzer::Sentiment < Analyzer

  protected

  def parse_body(body)
    parsed_body = Oj.load(body)
    raise Analyzer::ApiLimitReached if parsed_body["statusInfo"] == "daily-transaction-limit-exceeded"
    return nil unless parsed_body["docSentiment"]
    sentiment = parsed_body["docSentiment"]
    {
      score: sentiment["score"].to_f,
      type: sentiment["type"]
    }
  end

end