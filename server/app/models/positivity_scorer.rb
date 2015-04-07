class PositivityScorer

  DOCUMENT_SENTIMENT_WEIGHT = 2

  def self.score!(keywords, sentiment)
    document_score = sentiment[:score]
    keywords_count = keywords.size
    average_keywords_score = keywords.map { |k| k[:sentiment][:score] }.sum / keywords_count

    average_score = (document_score * DOCUMENT_SENTIMENT_WEIGHT + average_keywords_score) / 3.0

    # possible scores of 0 to 200 (-1 * 100 to 1 * 100)
    normalized_score = average_score * 100 + 100

    ((normalized_score / 200) * 100).round(2)
  end

end