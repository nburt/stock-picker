class ArticleAnalyzer

  def initialize(article)
    @article = article
  end

  def analyze!
    title = @article.title
    description = @article.description
    link = @article.link

    keywords = analyze_keywords(title, description, link)
    sentiment = analyze_sentiment(title, description, link)

    positivity_score = nil
    if keywords.any? && sentiment
      positivity_score = PositivityScorer.score!(keywords, sentiment)
    end

    struct = Struct.new(:keywords, :positivity_score, :sentiment)
    struct.new(keywords, positivity_score, sentiment)
  end

  private

  def analyze_keywords(title, description, link)
    title_keywords = extract_keywords(title)
    description_keywords = description.present? ? extract_keywords(description) : []
    link_keywords = extract_link_keywords(link)
    title_keywords.concat(description_keywords).concat(link_keywords)
  end

  def extract_keywords(text)
    keyword_analyzer = Analyzer::Keyword::TextKeyword.new(text)
    keyword_analyzer.analyze!
  end

  def extract_link_keywords(link)
    keyword_analyzer = Analyzer::Keyword::UrlKeyword.new(link)
    keyword_analyzer.analyze!
  end

  def analyze_sentiment(title, description, link)
    title_sentiment = extract_sentiment(title)
    title_score = title_sentiment ? title_sentiment[:score] : nil

    description_sentiment = extract_sentiment(description)
    description_score = description_sentiment ? description_sentiment[:score] : nil

    link_sentiment = extract_link_sentiment(link)
    link_score = link_sentiment ? link_sentiment[:score] : nil

    average_sentiment_score(title_score, description_score, link_score)
  end

  def extract_sentiment(text)
    sentiment_analyzer = Analyzer::Sentiment::TextSentiment.new(text)
    sentiment_analyzer.analyze!
  end

  def extract_link_sentiment(link)
    sentiment_analyzer = Analyzer::Sentiment::UrlSentiment.new(link)
    sentiment_analyzer.analyze!
  end

  def average_sentiment_score(title_score, description_score, link_score)
    average_score = SentimentAverager.average!(title_score, description_score, link_score)

    return nil unless average_score

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