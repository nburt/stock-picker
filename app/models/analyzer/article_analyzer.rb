class Analyzer::ArticleAnalyzer

  def initialize(article)
    @article = article
  end

  def analyze!
    keyword_analyzer = Analyzer::Keyword.new(@article)
    keywords = keyword_analyzer.analyze!
    sentiment_analyzer = Analyzer::Sentiment.new(@article)
    sentiment = sentiment_analyzer.analyze!

    positivity_score = nil
    if keywords.any? && sentiment
      positivity_score = PositivityScorer.score!(keywords, sentiment)
    end

    struct = Struct.new(:keywords, :positivity_score)
    struct.new(keywords, positivity_score)
  end

end