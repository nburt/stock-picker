namespace :score do
  desc "Score New Articles"
  task articles: :environment do
    articles = Article.where("created_at < ? AND created_at > ?", DateTime.now, 1.day.ago)
    count = articles.size
    articles.each_with_index do |article, index|
      p "#{index + 1} out of #{count}"
      article.analyze!
    end
  end

  desc "Score new tweets"
  task tweets: :environment do
    tweets = Tweet.where("created_at < ? AND created_at > ?", DateTime.now, 1.day.ago)
    count = tweets.size
    tweets.each_with_index do |tweet, index|
      p "#{index + 1} out of #{count}"
      tweet.analyze!
    end
  end
end