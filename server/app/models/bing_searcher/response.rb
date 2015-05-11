class BingSearcher::Response

  def initialize(result)
    @result = result
  end

  def date
    @result["Date"]
  end

  def title
    @result["Title"]
  end

  def link
    @result["Url"]
  end

  def description
    @result["Description"]
  end

  def source
    @result["Source"]
  end

end