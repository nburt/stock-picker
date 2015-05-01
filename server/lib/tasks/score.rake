namespace :score do
  IDS = [1, 4, 2, 7, 3, 6, 5, 8]

  desc "Score New Articles"
  task articles: :environment do
    articles = Article.where(stock_id: STOCK_IDS).unscored.first(200)
    count = articles.size
    articles.each_with_index do |article, index|
      p "#{index + 1} out of #{count}"
      article.analyze!
    end
  end

  desc "Score new tweets"
  task tweets: :environment do
    tweets = Tweet.where(stock_id: STOCK_IDS).unscored.first(400)
    count = tweets.size
    tweets.each_with_index do |tweet, index|
      p "#{index + 1} out of #{count}"
      tweet.analyze!
    end
  end

  desc "score new reddits"
  task reddits: :environment do
    reddits = Reddits.where(stock_id: STOCK_IDS).unscored.first(400)
    count = reddits.size
    reddits.each_with_index do |reddit, index|
      p "#{index + 1} out of #{count}"
      reddit.analyze!
    end
  end
end