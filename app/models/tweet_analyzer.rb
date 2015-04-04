class TweetAnalyzer

  def initialize(tweet)
    @tweet = tweet
  end

  def analyze!
    text = @tweet.data["text"]

    keywords = analyze_keywords(text)
    sentiment = analyze_sentiment(text)

    positivity_score = nil

    if keywords.any? && sentiment
      positivity_score = PositivityScorer.score!(keywords, sentiment)
    end

    struct = Struct.new(:keywords, :positivity_score, :sentiment)
    struct.new(keywords, positivity_score, sentiment)
  end

  private

  def analyze_keywords(text)
    keyword_analyzer = Analyzer::Keyword.new(text)
    keyword_analyzer.analyze!
  end

  def analyze_sentiment(text)
    sentiment_analyzer = Analyzer::Sentiment.new(text)
    sentiment_analyzer.analyze!
  end

end