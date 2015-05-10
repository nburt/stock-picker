class Analytics::Reddits

  def self.added(start_date, end_date)
    Reddit.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

  def self.total(date)
    Reddit.where("created_at <= ?", date).count
  end

  def self.total_scored(date)
    Reddit.scored.where("updated_at <= ?", date).count
  end

  def self.scored_by_interval(start_date, end_date)
    Reddit.scored.where("updated_at >= ? AND updated_at <= ?", start_date, end_date).count
  end

end