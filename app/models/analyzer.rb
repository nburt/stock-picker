class Analyzer

  def initialize(text)
    @text = text
    @api_key = ENV['ALCHEMY_API_KEY']
  end

end