class Analytics::Reddits

  def self.added(start_date, end_date)
    Reddit.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

  def self.total(date)
    Reddit.where("created_at <= ?", date).count
  end

  def self.total_scored(date)
    Reddit.scored.where("created_at <= ?", date).count
  end

end