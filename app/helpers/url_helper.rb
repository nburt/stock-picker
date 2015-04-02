module UrlHelper

  def tweet_url(data)
    "https://twitter.com/#{data["user"]["screen_name"]}/status/#{data["id_str"]}"
  end

end