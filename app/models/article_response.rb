class ArticleResponse

  def initialize(article)
    @article = article
  end

  def title
    @article[:title]
  end

  def description
    @article[:description]
  end

  def date
    @article[:date]
  end

  def link
    @article[:link]
  end

end