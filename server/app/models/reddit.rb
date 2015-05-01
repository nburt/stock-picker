class Reddit < ActiveRecord::Base
  belongs_to :stock

  validates_presence_of :stock_id, :title, :date, :link

  def analyze!
    return false if keywords.present? && keywords.size > 0 || keywords == [] || positivity_score.to_f > 0

    analyzer = RedditAnalyzer.new(self)
    analysis = analyzer.analyze!
    update_attributes(
      keywords: analysis.keywords,
      positivity_score: analysis.positivity_score,
      sentiment: analysis.sentiment
    )
  end

end
