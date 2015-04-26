class Analytics::Articles

  def self.added(start_date, end_date)
    Article.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

end