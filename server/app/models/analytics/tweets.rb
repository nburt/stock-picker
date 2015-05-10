class Analytics::Tweets

  def self.added(start_date, end_date)
    Tweet.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

  def self.total(date)
    Tweet.where("created_at <= ?", date).count
  end

  def self.total_scored(date)
    Tweet.scored.where("created_at <= ?", date).count
  end

  def self.scored_by_interval(start_date, end_date)
    Tweet.scored.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

end