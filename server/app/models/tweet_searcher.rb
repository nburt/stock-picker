class TweetSearcher

  def initialize(search_term)
    @search_term = search_term
    @client = create_client
  end

  def search
    response = @client.search(@search_term)
    parse_response(response)
  end

  private

  def parse_response(response)
    response.attrs[:statuses]
  end

  def create_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

end