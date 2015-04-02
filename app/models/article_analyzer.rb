class ArticleAnalyzer

  def initialize(article)
    @article = article
  end

  def analyze!
    title = @article.title
    description = @article.description

    keywords = analyze_keywords(title, description)
    sentiment = analyze_sentiment(title, description)

    positivity_score = nil
    if keywords.any? && sentiment
      positivity_score = PositivityScorer.score!(keywords, sentiment)
    end

    struct = Struct.new(:keywords, :positivity_score)
    struct.new(keywords, positivity_score)
  end

  private

  def analyze_keywords(title, description)
    title_keywords = extract_keywords(title)
    description_keywords = description.present? ? extract_keywords(description) : []
    title_keywords.concat(description_keywords)
  end

  def extract_keywords(text)
    keyword_analyzer = Analyzer::Keyword.new(text)
    keyword_analyzer.analyze!
  end

  def analyze_sentiment(title, description)
    title_sentiment = extract_sentiment(title)
    title_score = title_sentiment ? title_sentiment[:score] : nil

    description_sentiment = extract_sentiment(description)
    description_score = description_sentiment ? description_sentiment[:score] : nil

    average_sentiment_score(title_score, description_score)
  end

  def extract_sentiment(text)
    sentiment_analyzer = Analyzer::Sentiment.new(text)
    sentiment_analyzer.analyze!
  end

  def average_sentiment_score(title_score, description_score)
    return nil unless title_score || description_score

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

end