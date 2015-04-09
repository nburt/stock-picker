namespace :score do
  desc "Score New Articles"
  task articles: :environment do
    articles = Article.unscored
    count = articles.size
    articles.each_with_index do |article, index|
      p "#{index + 1} out of #{count}"
      article.analyze!
    end
  end

  desc "Score new tweets"
  task tweets: :environment do
    tweets = Tweet.unscored
    count = tweets.size
    tweets.each_with_index do |tweet, index|
      p "#{index + 1} out of #{count}"
      tweet.analyze!
    end
  end
end