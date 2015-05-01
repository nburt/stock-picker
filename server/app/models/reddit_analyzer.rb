class RedditAnalyzer

  def initialize(reddit)
    @reddit = reddit
  end

  def analyze!
    title = @reddit.title
    link = @reddit.link

    keywords = analyze_keywords(title, link)
    sentiment = analyze_sentiment(title, link)

    positivity_score = nil

    if keywords.any? && sentiment
      positivity_score = PositivityScorer.score!(keywords, sentiment)
    end

    analysis = Struct.new(:keywords, :positivity_score, :sentiment)
    analysis.new(keywords, positivity_score, sentiment)
  end

  private

  def analyze_keywords(title, link)
    title_keywords = extract_keywords(title)
    link_keywords = extract_link_keywords(link)
    title_keywords.concat(link_keywords)
  end

  def extract_keywords(text)
    keyword_analyzer = Analyzer::Keyword::TextKeyword.new(text)
    keyword_analyzer.analyze!
  end

  def extract_link_keywords(link)
    keyword_analyzer = Analyzer::Keyword::UrlKeyword.new(link)
    keyword_analyzer.analyze!
  end

  def analyze_sentiment(title, link)
    title_sentiment = extract_sentiment(title)
    title_score = title_sentiment ? title_sentiment[:score] : nil

    link_sentiment = extract_link_sentiment(link)
    link_score = link_sentiment ? link_sentiment[:score] : nil

    average_sentiment_score(title_score, link_score)
  end

  def extract_sentiment(text)
    sentiment_analyzer = Analyzer::Sentiment::TextSentiment.new(text)
    sentiment_analyzer.analyze!
  end

  def extract_link_sentiment(link)
    sentiment_analyzer = Analyzer::Sentiment::UrlSentiment.new(link)
    sentiment_analyzer.analyze!
  end

  def average_sentiment_score(title_score, link_score)
    average_score = SentimentAverager.average!(title_score, nil, link_score)

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