class Analytics::Tweets

  def self.added(start_date, end_date)
    Tweet.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

end