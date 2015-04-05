class SentimentAverager

  def self.average!(title_score, description_score, link_score)
    return nil unless title_score || description_score || link_score

    array = [title_score, description_score, link_score].compact
    array.sum.to_f / array.size.to_f
  end

end