class Analytics::Articles

  def self.added(start_date, end_date)
    Article.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

  def self.total(date)
    Article.where("created_at <= ?", date).count
  end

  def self.total_scored(date)
    Article.scored.where("created_at <= ?", date).count
  end

  def self.scored_by_interval(start_date, end_date)
    Article.scored.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

end