class Article < ActiveRecord::Base
  belongs_to :stock

  validates_presence_of :stock_id, :title, :date, :link

  def analyze!
    return false if keywords.present? && keywords.size > 0 || positivity_score.to_f > 0
    analyzer = Analyzer::Article.new(self)
    analysis = analyzer.analyze!
    update_attributes(keywords: analysis.keywords, positivity_score: analysis.positivity_score)
  end

end
