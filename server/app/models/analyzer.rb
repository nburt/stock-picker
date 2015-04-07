class Analyzer

  def initialize(content)
    @content = content
    @api_key = ENV['ALCHEMY_API_KEY']
  end

end