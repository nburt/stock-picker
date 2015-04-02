class Tweet < ActiveRecord::Base
  belongs_to :stock

  scope :scored, -> { where("positivity_score IS NOT NULL") }

  def analyze!
    return false if keywords.present? && keywords.size > 0 || positivity_score.to_f > 0
    analyzer = TweetAnalyzer.new(self)
    analysis = analyzer.analyze!
    update_attributes(keywords: analysis.keywords, positivity_score: analysis.positivity_score)
  end
end
