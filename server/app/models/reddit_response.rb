class RedditResponse

  def initialize(reddit)
    @reddit = reddit
  end

  def title
    data["title"]
  end

  def link
    data["url"]
  end

  def date
    (Time.at(data["created"])).to_datetime
  end

  def data
    @reddit["data"]
  end

  def subreddit_id
    data["subreddit_id"]
  end

end