class Analyzer

  def initialize(article)
    @article = article
    @api_key = ENV['ALCHEMY_API_KEY']
  end

end