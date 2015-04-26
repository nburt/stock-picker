class Tweet < ActiveRecord::Base
  belongs_to :stock

  scope :scored, -> { where("positivity_score IS NOT NULL") }
  scope :unscored, -> { where("positivity_score IS NULL AND keywords::text IS NULL") }

  def analyze!
    return false if keywords.present? && keywords.size > 0 || keywords == [] || positivity_score.to_f > 0
    analyzer = TweetAnalyzer.new(self)
    analysis = analyzer.analyze!
    update_attributes(
      keywords: analysis.keywords, positivity_score: analysis.positivity_score,
      sentiment: analysis.sentiment
    )
  end
end
