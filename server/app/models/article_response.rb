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

  def data
    @article[:data]
  end

  def source
    @article[:source]
  end

  def section
    @article[:section]
  end

end